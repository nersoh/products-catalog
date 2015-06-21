class ApplicationController < ActionController::Base
	include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def logged_in_user
    unless logged_in?
      flash[:danger] = "You must be logged in."
      redirect_to login_url
    end
  end

  private

  def user_not_authorized
    flash[:danger] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
