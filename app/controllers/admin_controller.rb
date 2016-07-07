class AdminController < ApplicationController
  before_action :authentication
  
  def index
    if params[:set_locale]
      redirect_to admin_url(locale: params[:set_locale])
    end
  end
  
  def authentication
    if logged_in?
    else
      redirect_to login_path
    end
  end
end
