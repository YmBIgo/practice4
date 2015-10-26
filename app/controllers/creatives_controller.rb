class CreativesController < ApplicationController
  def index
    @wears = Wear.all.order("created_at DESC").page(params[:page])
  end
end
