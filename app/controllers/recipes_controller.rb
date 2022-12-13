class RecipesController < ApplicationController
    # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.order(:id).page(params[:page]).per(2)
  end

  # GET /recipes/1 or /recipes/1.json
  def show; end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id

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

  # PATCH/PUT /recipes/1 or /recipes/1.json
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

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def public
    @recipes = Recipe.where(public: true).order(:id).page(params[:page]).per(2)
    @total_price = []
    @recipes.each do |recipe|
      @total_price << recipe.recipe_foods.inject(0) { |sum, e| sum + (e.food.price * e.quantity) }
    end
    # @total_price = @recipes.each do |recipe|
    #  recipe.inject(0){|sum,e| sum + (e.price * e.quantity)}
    # end
  end

  def shopping_list
    @ingredient = RecipeFood.where(recipe_id: params[:recipe_id])
    @total_price = @ingredient.inject(0) { |sum, e| sum + (e.food.price * e.quantity) }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
