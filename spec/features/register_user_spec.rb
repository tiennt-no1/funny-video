RSpec.describe 'Register new user', type: :feature, js: true do
  let (:user) { build :user }
  scenario 'valid inputs' do
    visit new_user_path
    fill_in 'user_username', with: user.username
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password
    click_button 'register'
    expect(page).to have_current_path(auth_new_path)

  end

  context 'invalid input' do
    scenario 'empty username inputs' do
      visit new_user_path
      fill_in 'user_username', with: user.username
      # fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password
      click_button 'register'
      wait_for_ajax
      expect(page).to have_selector('h2.swal2-title', text: "Password can't be blank")
    end
  end

  context 'invalid input' do
    scenario 'empty username inputs' do
      visit new_user_path
      fill_in 'user_username', with: user.username
      # fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password
      click_button 'register'
      wait_for_ajax
      expect(page).to have_selector('h2.swal2-title', text: "Password can't be blank")
    end
  end

  context 'invalid input' do
    scenario 'empty username inputs' do
      visit new_user_path
      fill_in 'user_username', with: user.username
      fill_in 'user_password', with: user.password
      # fill_in 'user_password_confirmation', with: user.password
      click_button 'register'
      wait_for_ajax
      expect(page).to have_selector('h2.swal2-title', text: "Password confirmation doesn't match Password")
    end
  end


end