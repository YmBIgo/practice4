class AdminController < ApplicationController

  before_action :admin_user
  def show
    @users = User.all.page(params[:page])
  end

  private

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
