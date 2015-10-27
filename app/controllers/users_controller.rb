class UsersController < ApplicationController

  before_action :correct_user,  only: [:show, :edit, :update]
  before_action :editable_user, only: [:edit, :update]
  before_action :admin_user,    only: [:destroy]

  def show
    @user = User.find(params[:id])
    @wears = @user.wears.order("created_at DESC").page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
    @wards = Ward.all
    if current_user.ward!=nil
      @ward = current_user.ward
    else
      @ward = Ward.first
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(update_params)
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:suceess] = "User destroyed"
    redirect_to root_path
  end

  def stations_select
    if request.xhr?
      render partial: 'stations', locals: { ward_id: params[:ward_id]}
    end
  end

  private

  def correct_user
    @user = User.find(params[:id])
    if !current_user.present?
      redirect_to(root_path)
    end
  end

  def editable_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user.admin? || @user.id == current_user.id
  end

  def update_params
    params.require(:user).permit(:family_name, :first_name, :station_id, :ward_id, :image)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
