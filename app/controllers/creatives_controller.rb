class CreativesController < ApplicationController
  def index
    @wears = Wear.all.page(params[:page])
  end
end
