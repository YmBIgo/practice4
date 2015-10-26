class StaticPagesController < ApplicationController

  before_action :correct_user

  def usearch
    @users = User.where(:station_id => "#{current_user.station.id}").order("created_at DESC").page(params[:page])
  end

  def correct_user
    redirect_to(root_path) unless user_signed_in?
  end

end
