class ApplicationController < ActionController::Base
  layout 'base'

  class Forbidden < ActionController::ActionControllerError; end
  include ErrorHandlers if Rails.env.production?
end
