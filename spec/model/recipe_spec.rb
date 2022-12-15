require 'rails_helper'

RSpec.describe Recipe, type: :model do
    let(:recipe) do
        Recipe.new(name: 'recipe 1', user: User.new(name: 'name', password: 'password123', email: 'hana@gmail.com'))
    end

    describe 'Model validation' do
        it 'Passes validation' do
            expect(recipe).to be_valid
        end

        it 'Validates :name presence' do
            recipe.name = nil
            expect(recipe).to_not be_valid
        end
        end

  it 'Validates :user presence' do
    recipe.user = nil
    expect(recipe).to_not be_valid
  end
end