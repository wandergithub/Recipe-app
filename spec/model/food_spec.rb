require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:food) do
    Food.new(name: 'food 1', user: User.new(name: 'name', password: 'password123', email: 'sample@exmaple.com'))
  end

  describe 'Model validation' do
    it 'Passes validation' do
      expect(food).to be_valid
    end

    it 'Validates :name presence' do
      food.name = nil
      expect(food).to_not be_valid
    end
  end
end
