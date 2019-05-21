class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :sign_up_code

  # Associations
  has_one :secret_code, dependent: :destroy
  has_and_belongs_to_many :roles

  # Validations
  validates :sign_up_code, presence: true, on: :create, unless: -> { has_role? :admin }
  validate :signup_code, on: :create, if: -> { sign_up_code.present? }

  # Callbacks
  after_create :associate_secret_code


  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end

  private

    def signup_code
      if invalid_sign_up_code?
        errors.add(:sign_up_code, 'invalid')
      elsif used_sign_up_code?
        errors.add(:sign_up_code, 'cannot be used more than once')
      end
    end

    def invalid_sign_up_code?
      SecretCode.where(code: sign_up_code).empty?
    end

    def used_sign_up_code?
      SecretCode.where(code: sign_up_code).where.not(user_id: nil).present?
    end

    def associate_secret_code
      self.secret_code = SecretCode.find_by_code(sign_up_code)
      save!
    end

end
