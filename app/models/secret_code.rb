class SecretCode < ApplicationRecord

  OPTION_VALUES_FOR_GENERATION = [1, 10, 20, 50, 100]
  DEFAULT_GENERATION_NUMBER = 10

  # Associations
  belongs_to :user, optional: true

  # Validations
  validates :code, uniqueness: { case_sensitive: false }

  has_secure_token :code

end
