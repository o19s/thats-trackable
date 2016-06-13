class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include PublicActivity::StoreController

  before_action :require_login

  private

  def require_login
    unless logged_in?
      flash[:info] = "Please sign in to use RunTracker and get tracking!"
      redirect_to login_path # halts request cycle
    end
  end



end
