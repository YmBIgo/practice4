class WearsController < ApplicationController

  before_action :correct_user
  before_action :editable_user ,only: [:edit, :update]

  def index
    @wears = Wear.search(params)
  end

  def new
    @wear = Wear.new
  end

  def create
    @wear = Wear.create(create_params)
  end

  def show
    @wear = Wear.find(params[:id])
    @user = @wear.user
  end

  def edit
    @wear = Wear.find(params[:id])
    @user = @wear.user
  end

  def update
    @wear = Wear.find(params[:id])
    @wear.update(update_params)
  end

  private

  def correct_user
    if !current_user.present?
      redirect_to(root_path)
    else
       redirect_to(root_path) unless current_user.full_profile?
    end
  end


  def editable_user
    @user = Wear.find(params[:id]).user
    redirect_to(root_path) unless current_user.admin? || current_user.id == @user.id
  end

  def create_params
    params.require(:wear).permit(:price, :month_price, :brand_id, :wimage, :user_id).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:wear).permit(:price, :month_price, :brand_id, :wimage,:user_id).merge(user_id: current_user.id)
  end
end
