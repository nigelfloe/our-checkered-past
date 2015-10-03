class HomeController < ApplicationController
  before_action :authenticate_user!, :except => [:index]

  def index
    # if !user_signed_in?
    #   redirect_to '/users/sign_in'
    # end
  end
end
