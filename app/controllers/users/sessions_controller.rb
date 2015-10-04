class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /users/sign_in
def create
  self.resource = warden.authenticate!(auth_options)
  set_flash_message(:notice, :signed_in) if is_navigational_format?
  if sign_in(resource_name, resource)
    respond_with resource, location: after_sign_in_path_for(resource)
  else
    respond_with resource, location: root_path
  end
end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
