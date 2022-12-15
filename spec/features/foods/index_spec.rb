require 'rails_helper'

describe 'Show all foods of current user', type: :feature do
  before(:each) do
    # Log in
    @user = User.create(id: 1, name: 'example', email: 'example@gmail.com', password: '1234567')
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button 'Log in'
    # end
    @food = Food.create(user: @user, name: 'food 1', measurement_unit: 'grams', price: 12, quantity: 3)
  end
  context 'visit /foods' do
    before(:example) do
      visit foods_path
    end

    it 'Can see foods table' do
      expect(page).to have_content('Food')
      expect(page).to have_content('Quantity')
      expect(page).to have_content('Measurement unit')
    end

    it 'Can see a User created food' do
      expect(page).to have_content(@food.name)
    end

    it 'Can delete a User created food' do
      expect(page).to have_content(@food.name)
      click_link 'Delete'
      expect(page).to_not have_content(@food.name)
    end

    it 'Can take the user to Add Food form' do
      expect(page).to have_current_path(foods_path)

      click_link 'Add Food'
      expect(page).to have_current_path(new_food_path)
    end
  end
end
