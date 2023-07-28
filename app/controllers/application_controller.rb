class ApplicationController < ActionController::Base
  helper_method :current_user
  add_flash_types :success, :info, :warning, :danger

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in_user
    unless current_user
      flash[:danger] = t('defaults.message.require_login')
      redirect_back(fallback_location: posts_path)
    end
  end

  def logged_in?
    !current_user.nil?
  end
end
