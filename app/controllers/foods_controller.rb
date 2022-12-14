class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = Food.where(user: current_user)
    @food = Food.new
  end

  def create
    food = Food.new(food_params)
    food.user = current_user
    flash[:message] = if food.save
                        'Food created successfully'
                      else
                        "Food wasn't create"
                      end
    redirect_to foods_path
  end

  def destroy
    food = Food.find(params[:id])

    flash[:message] = if food.destroy
                        'Food deleted'
                      else
                        'Food could not be deleted'
                      end
    redirect_to foods_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end
end
