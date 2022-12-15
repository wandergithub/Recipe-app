class RecipeFoodsController < ApplicationController
  def new
    @recipe_food = RecipeFood.new
    @recipe_food.recipe_id = params[:recipe_id]
    @foods = Food.all
  end

  def create
    @recipe_food = RecipeFood.new
    @recipe_food.recipe_id = params[:recipe_id]
    @recipe_food.food_id = params[:food_id]
    @recipe_food.quantity = params[:quantity]
    respond_to do |format|
      if @recipe_food.save
        format.html { redirect_to recipe_url(@recipe_food.recipe_id), notice: 'Recipe food was successfully created.' }
        format.json { render :show, status: :created, location: @recipe_food }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe_food.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
    p(@recipe_food)
    @foods = Food.all
  end

  def update
    @recipe_food = RecipeFood.find_by(recipe_id: params[:id])
    @recipe_food.quantity = params[:quantity]
    respond_to do |format|
      if @recipe_food.save
        format.html { redirect_to recipe_url(@recipe_food.recipe_id), notice: 'Recipe food was successfully updated.' }
        format.json { render :show, status: :created, location: @recipe_food }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe_food.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    respond_to do |format|
      format.html { redirect_to recipe_url(@recipe_food.recipe_id), notice: 'Recipe food was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_recipe_food
    @recipe_food = RecipeFood.find(params[:id])
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :recipe_id, :food_id)
  end
end
