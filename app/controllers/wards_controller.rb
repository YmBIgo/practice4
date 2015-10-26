class WardsController < ApplicationController
  def show
    @ward = Ward.find(params[:id])
    @stations = @ward.stations
  end
end
