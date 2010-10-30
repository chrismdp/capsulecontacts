class ApplicationController < ActionController::Base

  before_filter :authenticate

  include SslRequirement

  def ssl_required?
    Rails.env == 'production'
  end

  protect_from_forgery

private

  def authenticate
    return if Rails.env != 'production'
    authenticate_or_request_with_http_basic do |user_name, password|
      (user_name == ENV['BASICAUTH_USER'] && password == ENV['BASICAUTH_PASS'])
    end
  end
end
