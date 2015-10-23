class UsersController < ApplicationController

  before_action :correct_user, only: [:edit, :update]

  def index
  end

  def edit
  end

  def update
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless @user.id==current_user.id
  end

end
