RSpec.describe 'Register new user', type: :feature, js: true do
  let (:user) { create :user }
  scenario 'valid inputs' do
    visit auth_new_path
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    click_button 'login'
    expect(page).to have_current_path(videos_path)
    expect(page).to have_content "Welcome"
    expect(page).to have_selector("nav b", text: user.username)
    expect(page).to have_selector("button", text: "Share video")
    expect(page).to have_selector("button#logout", text: "Log out")

    click_button 'logout'
    expect(page).not_to have_selector("button", text: "Share video")
    expect(page).not_to have_selector("button#logout", text: "Log out")
  end
end