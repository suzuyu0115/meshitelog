class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    user = User.find_or_create_from_auth(auth)
    session[:user_id] = user.id
    redirect_to root_path, notice: 'ログインしました'
  end
end
