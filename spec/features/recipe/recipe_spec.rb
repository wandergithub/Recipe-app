require 'rails_helper'

RSpec.describe 'Recipe Food page', type: :feature do
  before :each do
    @user = User.create!(name: 'Hana', email: 'hana@gmail.com', password: '1234567',
                         password_confirmation: '1234567')
    @recipe = Recipe.create!(name: 'Chicken', description: 'Chicken is a good food', user_id: @user.id)
    @food = Food.create!(name: 'Chicken', quantity: 1, user_id: @user.id)
    @recipe_food = RecipeFood.create!(recipe_id: @recipe.id, food_id: @food.id)

    visit new_user_session_path
    fill_in 'Email', with: 'hana@gmail.com'
    fill_in 'Password', with: '1234567'
    click_button 'Log in'
  end

  it 'should be able to see Recipes' do
    visit recipe_food_path(@recipe_food)
    expect(page).to have_content('Chicken')
  end

  it 'should be able to see Foods' do
    visit recipe_food_path(@recipe_food)
    expect(page).to have_content('Chicken')
  end

  it "shouldn't be able to remove if you are not the owner of the recipe" do
    @user2 = User.create!(name: 'Abebe', email: 'abebe@csc.et', password: '1234567',
                          password_confirmation: '1234567')
    @recipe2 = Recipe.create!(name: 'Chicken', description: 'Chicken is a good food', user_id: @user2.id)
    @food2 = Food.create!(name: 'Chicken', quantity: 1, user_id: @user2.id)
    @recipe_food2 = RecipeFood.create!(recipe_id: @recipe2.id, food_id: @food2.id)
    visit recipe_food_path(@recipe_food2)
    expect(page).not_to have_content('Remove')
  end
end
