require 'rails_helper'

RSpec.describe 'Recipe Food page', type: :feature do
  before :each do
    @user = User.create!(name: 'Abebe', email: 'abebe@gmail.com', password: '1234567',
                         password_confirmation: '1234567')
    @recipe = Recipe.create!(name: 'Chicken', description: 'Chicken is a good food', user_id: @user.id)
    @food = Food.create!(name: 'Chicken', quantity: 1, user_id: @user.id)
    @recipe_food = RecipeFood.create!(recipe_id: @recipe.id, food_id: @food.id)

    visit new_user_session_path
    fill_in 'Email', with: 'abebe@gmail.com '
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
end
