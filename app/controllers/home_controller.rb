class HomeController < ApplicationController
  before_action :authenticate_user!, :except => [:index]
  helper_method :resource_name, :resource, :devise_mapping

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def index
    # if !user_signed_in?
    #   redirect_to '/users/sign_in'
    # end
  end
end
