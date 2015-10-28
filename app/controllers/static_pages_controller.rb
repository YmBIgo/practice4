class StaticPagesController < ApplicationController

  before_action :correct_user, only:[:usearch]

  def usearch
    @users = User.where(:station_id => "#{current_user.station.id}").order("created_at DESC").page(params[:page])
  end

  def show
  end

  private

  def correct_user
    if !current_user.present?
      redirect_to(root_path)
    end
  end

end
