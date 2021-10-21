class SessionsController < Devise::SessionsController

  # def create
  #   user = User.find_by_email(sign_in_params[:email])
  #   # puts "hkdjs"
  #   # logger.debug sign_in_params
  #   if user && user.valid_password?(sign_in_params[:password])
  #     @current_user = user
  #   else
  #     render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
  #   end
  # end

  protected

  def after_sign_in_path_for(resource)
      root_path
  end
  
end