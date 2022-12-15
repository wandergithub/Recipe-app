require 'rails_helper'

describe '/foods/new foods form', type: :feature do
  before(:each) do
    # Log in
    @user = User.create(id: 1, name: 'example', email: 'example@gmail.com', password: '1234567')
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button 'Log in'
    # visit /foods/new form
    visit new_food_path
  end

  context 'Visit /foods/new form' do
    it 'Can see foods/new form' do
      expect(page).to have_css('form')
    end

    it 'Can create a new food' do
      expect(Food.first).to equal nil
      fill_in 'food_name', with: 'food sample'
      select 'grams', from: 'food_measurement_unit'
      fill_in 'food_quantity', with: 2
      fill_in 'food_price', with: 3
      click_button 'Add Food'
      expect(Food.first).to_not equal nil
    end
  end
end
