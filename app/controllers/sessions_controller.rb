class SessionsController < ApplicationController
  def create
    user = User.from_omniauth auth
    if user
      session[:user_id] = user.id
      session[:auth_user_photo_url] = auth.info.image
      redirect_to root_path
    else
      redirect_to root_path, alert: 'Invalid authentication request'
    end
  end

  def destroy
    session.delete :user_id
    session.delete :auth_user_photo_url
    redirect_to root_path
  end

  private

  def auth
    env['omniauth.auth']
  end
end
