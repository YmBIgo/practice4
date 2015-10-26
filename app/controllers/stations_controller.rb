class StationsController < ApplicationController

  before_action :correct_user

  def show
    @station = Station.find(params[:id])
    @users = @station.users
    @wears = Wear.where(:user_id => @users).order("created_at DESC").page(params[:page])
  end

  def correct_user
    redirect_to(root_path) unless user_signed_in?
  end

end
