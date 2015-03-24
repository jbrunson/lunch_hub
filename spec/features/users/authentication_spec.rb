require 'rails_helper'

feature 'Authentication', js: true do
  before do
    @user = FactoryGirl.create(:confirmed_user)
    visit '/sign_in'
    @login_page = LoginPage.new
    @login_page.sign_in(@user.email, @user.password)
  end

  feature 'login' do
    scenario 'with valid inputs' do
      @login_page.sign_in(@user.email, @user.password)
      expect(page).to have_content('Sign Out')
    end

    scenario 'with invalid credentials' do
      @login_page.sign_in("invalid@lol.com", "not the actual password")
      expect(page).to have_content("invalid login credentials. Please try again.")
    end

    scenario 'redirect after login' do
      @login_page.sign_in(@user.email, @user.password)
      expect(page).to have_content('This is the home page.')
    end
  end

  feature 'page access' do
    scenario 'visiting groups page when signed in' do
      @login_page.sign_in(@user.email, @user.password)

      #capybara wait for sign-in to finish before visiting /groups
      expect(page).to have_css('h1', text: 'Home')

      visit '/groups'
      expect(page).to have_css('h1', text: 'Groups')
    end

    scenario 'visiting "groups" page wehn not signed in' do
      visit '/groups'
      expect(page).not_to have_css('h1', text: 'Groups')
    end
  end
end