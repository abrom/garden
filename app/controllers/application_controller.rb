class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_user_photo_url

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user.present?
  end

  def current_user_photo_url
    session[:auth_user_photo_url]
  end

  def authenticate_user!
    redirect_to root_path unless current_user.present?
  end
end
