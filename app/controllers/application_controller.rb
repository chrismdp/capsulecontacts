class ApplicationController < ActionController::Base

  before_filter :authenticate

  include SslRequirement

  def ssl_required?
    Rails.env != 'development'
  end

  protect_from_forgery

private

  def authenticate
    authenticate_or_request_with_http_basic do |user_name, password|
      (user_name == 'edendevelopment' && password == 't77cn32X')
    end
  end
end
