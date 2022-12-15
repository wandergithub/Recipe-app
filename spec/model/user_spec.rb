require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    let(:user) { User.new(name: "name 1", email: "example@hotmail.com", password: "example_password") }

    it "Passes validation" do
      expect(user).to be_valid
    end

    it "Validates :name presence" do
      user.name = nil
      expect(user).to_not be_valid
    end
  end
end
