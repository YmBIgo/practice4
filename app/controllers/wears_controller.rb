class WearsController < ApplicationController

  before_action :correct_user, only:[:new, :create, :show,:edit, :update]

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
  end

  def update
  end

  private

  def correct_user
    redirect_to(root_path) unless user_signed_in?
  end

  def create_params
    params.require(:wear).permit(:price, :brand_id, :avatar,:user_id).merge(user_id: current_user.id)
  end
end
