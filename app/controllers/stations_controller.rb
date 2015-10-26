class StationsController < ApplicationController

  before_action :correct_user

  def show
    @station = Station.find(params[:id])
    @users = @station.users
    @wears = Wear.where(:user_id => @users).order("created_at DESC").page(params[:page])
  end

  private

  def correct_user
    if !current_user.present?
      redirect_to(root_path)
    else
      redirect_to(root_path) unless current_user.full_profile?
    end
  end

end
