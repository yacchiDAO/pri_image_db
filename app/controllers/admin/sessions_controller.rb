class Admin::SessionsController < Admin::ApplicationController
  layout "application"
  skip_before_action :authenticate!, only: [:new, :create], raise: false

  def new
    @admin = Admin.new
    redirect_to admin_root_path, notice: "既にログインしています" if @current_admin
  end

  def create
    admin = Admin.find_by(login_id: admin_params[:login_id])

    if admin&.authenticate(admin_params[:password])

      session[:admin_id] = admin.id
      redirect_to admin_images_path, layout: "admin/application", notice: "ログインしました"
    else
      @admin = Admin.new(login_id: admin_params[:login_id])
      render "new", notice: "ログインに失敗しました"
    end
  end

  def destroy
    logout!
    redirect_to root_path, notice: "ログアウトしました", layout: "application"
  end

  private

    def admin_params
      params.require(:admin).permit(:login_id, :password)
    end
end
