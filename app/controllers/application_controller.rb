class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  force_ssl if: :ssl_configured?

  before_filter :wrap_site_in_basic_auth if
    Rails.application.secrets['basic_auth_username']
  before_filter :set_timezone

  private

  def ssl_configured?
    !Rails.env.development?
  end

  def wrap_site_in_basic_auth
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == Rails.application.secrets['basic_auth_username'] &&
       password == Rails.application.secrets['basic_auth_password']
    end
  end

  def set_timezone
    Time.zone = 'US/Pacific'
  end
end
