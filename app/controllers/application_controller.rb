class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  before_filter :password_protect
  def password_protect
    authenticate_or_request_with_http_basic do |username, password|
      [username, password] == [APP_CONFIG['username'], APP_CONFIG['password']]
    end
  end
  private :password_protect
end
