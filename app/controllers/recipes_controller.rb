class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    @recipes = Recipe.includes(recipe_foods: [:food]).order(:id).page(params[:page]).per(4)
  end

  
  def show
    @recipe = Recipe.find(params[:id])
  end

 
  def new
    @recipe = Recipe.new
  end

  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipes_url, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def public
    @recipes = Recipe.includes(:user, recipe_foods: [:food]).where(public: true).order(:id).page(params[:page]).per(2)
    @total_price = []
    @recipes.each do |recipe|
      @total_price << recipe.recipe_foods.inject(0) { |sum, e| sum + (e.food.price * e.quantity) }
    end
  end

  def shopping_list
    @ingredient = RecipeFood.includes(:food).where(recipe_id: params[:recipe_id])
    @total_price = @ingredient.inject(0) { |sum, e| sum + (e.food.price * e.quantity) }
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end


  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
