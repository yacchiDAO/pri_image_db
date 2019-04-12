class Admin::ApplicationController < ActionController::Base
  layout 'application'
  before_action :authenticate!
  helper_method :current_admin


  protected

  def logout!
    session[:admin_id] = nil
  end

  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  rescue ActiveRecord::RecordNotFound
    logout!
  end

  def authenticate!
    redirect_to admin_new_session_path unless current_admin
  end
end
