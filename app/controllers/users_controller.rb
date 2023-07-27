class UsersController < ApplicationController
  require 'net/http'
  require 'uri'

  def new
    if current_user
      redirect_to posts_path
    end
  end

  def create
      id_token = params[:idToken]
      name = params[:name]
      channel_id = ENV['LINE_CHANNEL_ID']
      res = Net::HTTP.post_form(URI.parse('https://api.line.me/oauth2/v2.1/verify'), { 'id_token' => id_token, 'client_id' => channel_id })
      line_user_id = JSON.parse(res.body)['sub']
      @user = User.find_or_create_by(line_user_id: line_user_id) do |user|
        user.name = name
      end
      session[:user_id] = @user.id
      render json: @user
  end

  def destroy
    reset_session
    redirect_to root_path, success: t('.success')
  end
end
