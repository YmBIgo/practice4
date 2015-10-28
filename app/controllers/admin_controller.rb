class AdminController < ApplicationController

  before_action :admin_user
  def show
    @users = User.all.page(params[:page])
  end

  private

  def admin_user
    if current_user.present?
      redirect_to(root_path) unless current_user.admin?
    else
      redirect_to(root_path)
    end
  end

end
