class SecretCodesController < ApplicationController

  before_action :validate_option_selection, only: :create
  load_and_authorize_resource

  def index
    @secret_codes = SecretCode.includes(:user).all
  end

  def create
    params[:number].to_i.times { SecretCode.create! }
    redirect_to secret_codes_path, notice: 'Codes have been generated successfully'
  end

  private

    def validate_option_selection
      unless SecretCode::OPTION_VALUES_FOR_GENERATION.include? params[:number].to_i
        flash[:error] = 'Invalid Selection. Please select a valid number'
        redirect_to secret_codes_path
      end
    end

end
