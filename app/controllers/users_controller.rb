class UsersController < ApplicationController

  before_action :correct_user, only: [:show, :edit, :update]

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
    current_user.update(update_params)
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
    else
    end
  end

  def update_params
    params.require(:user).permit(:family_name, :first_name, :station_id, :ward_id, :avatar)
  end

end
