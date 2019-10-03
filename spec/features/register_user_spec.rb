RSpec.describe 'Register new user', type: :feature do
  let (:user) {build :user}
  scenario 'valid inputs' do
    visit new_user_path
    fill_in 'user_username', with: user.username
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password
    click_on 'commit'
    expect(current_path).to eq auth_new_path
  end

  context 'invalid input' do
    scenario 'valid inputs' do
      visit new_user_path
      fill_in 'user_username', ''
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password
      click_on 'commit'
      expect(current_path).to eq auth_new_path
    end
  end



end