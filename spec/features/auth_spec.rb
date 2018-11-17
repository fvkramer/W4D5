require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'New User'
  end

  feature 'signing up a user' do
    before(:each) do
      visit new_user_url
      fill_in 'Username', with: 'insulted'
      fill_in 'Password', with: 'aggravated'
      click_on 'Create User'
    end

    scenario 'shows username on the homepage after signup' do
      expect(page).to have_content 'insulted'
    end

  end
end

feature 'logging in' do

  scenario 'has a login page' do
    visit new_session_url
    expect(page).to have_content "Log In!"
  end

  feature "after sign in" do
    before(:each) do
      visit new_session_url
      fill_in 'Username', with: 'still_insulted'
      fill_in 'Password', with: 'vexed420'
      click_on 'Moist Meeee'
    end

    scenario 'shows username on the homepage after login' do
      expect(page).to have_content 'still_insulted'
    end

  end
end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    
  end

  scenario 'doesn\'t show username on the homepage after logout'

end
