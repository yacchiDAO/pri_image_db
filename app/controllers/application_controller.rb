class ApplicationController < ActionController::Base
  layout 'base'
  before_action :check_smartphone

  class Forbidden < ActionController::ActionControllerError; end
  include ErrorHandlers if Rails.env.production?

  def check_smartphone
    @smartphone = request.from_smartphone?
  end
end
