class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    user = User.find_or_create_from_auth(auth)
    if user
      session[:user_id] = user.id
      redirect_to root_path, success: t('.success')
    else
      redirect_to root_path, danger: t('.fail')
    end
  end

  def destroy
    reset_session
    redirect_to root_path, success: t('.success')
  end
end
