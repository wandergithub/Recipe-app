require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
    before :each do
        @user = User.create!(name: 'Hana', email: 'hana@gmail.com', password: '1234567',
                                password_confirmation: '1234567')
        @recipe = Recipe.create!(name: 'Burgur', description: 'Chicken is a good food', user_id: @user.id)
        @food = Food.create!(name: 'Chicken', quantity: 1, user_id: @user.id)
        @recipe_food = RecipeFood.create!(recipe_id: @recipe.id, food_id: @food.id)

        end
        before { subject.save }

    it 'should be able to see Recipes' do
        expect(@recipe_food.recipe.name).to eq('Burgur')
    end

    it 'should be able to see Foods' do
        expect(@recipe_food.food.name).to eq('Chicken')
    end

    it 'quantity should be equal to or greater than 1' do
        subject.quantity = -2
        expect(subject).to_not be_valid
      end

    it 'food should be present' do
        subject.food = nil
        expect(subject).to_not be_valid
      end

      it 'quantity should be present' do
        subject.quantity = nil
        expect(subject).to_not be_valid
      end

    it 'recipe should be present' do
        subject.recipe = nil
        expect(subject).to_not be_valid
      end

end