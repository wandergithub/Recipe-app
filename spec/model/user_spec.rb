require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(name: 'name 1', email: 'example@hotmail.com', password: 'example_password') }

  describe 'Model validation' do
    it 'Passes validation' do
      expect(user).to be_valid
    end

    it 'Validates :name presence' do
      user.name = nil
      expect(user).to_not be_valid
    end
  end

  describe 'User authentication validation' do
    it 'Validates :email presence' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'Validates :password presence' do
      user.password = nil
      expect(user).to_not be_valid
    end
  end
end
