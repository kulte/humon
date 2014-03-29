class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def current_user
    User.find_or_create_by_device_token(params[:owner][:device_token])
  end
  helper_method :current_user
end
