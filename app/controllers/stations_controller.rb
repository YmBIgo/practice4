class StationsController < ApplicationController

  def show
    @station = Station.find(params[:id])
    @users = @station.users
    @wears = Wear.where(:user_id => @users).order("created_at DESC").page(params[:page])
  end

end
