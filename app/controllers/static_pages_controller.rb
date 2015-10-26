class StaticPagesController < ApplicationController
  def usearch
    @users = User.where(:station_id => "#{current_user.station.id}").order("created_at DESC").page(params[:page])
  end
end
