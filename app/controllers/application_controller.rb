class ApplicationController < ActionController::Base
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # protect_from_forgery with: :null_session
  # respond_to :json
  # before_action :underscore_params!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user
  include Pundit

  def default_action
      if user_signed_in?
          redirect_to root_path 
      else
          redirect_to new_user_session_path
      end 
  end

  

  private
  
  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
# ider
  # def authenticate_user
  #   if request.headers['Authorization'].present?
  #     authenticate_or_request_with_http_token do |token|
  #       begin
  #         jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first

  #         @current_user_id = jwt_payload['id']
  #       rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
  #         head :unauthorized
  #       end
  #     end
  #   end
  # end

  # def authenticate_user!(options = {})
  #   head :unauthorized unless signed_in?
  # end

  # def current_user
  #   # debugger
  #   @current_user ||= super || User.find(@current_user_id)
  # end

  # def signed_in?
  #   @current_user_id.present?
  # end
# ider
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def record_not_found
      redirect_to '/500'
  end
end
