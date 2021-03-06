class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # Check for authorization
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
end
