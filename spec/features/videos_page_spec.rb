RSpec.describe 'Show list video', type: :feature, js: true do
  let (:user) {create :user}
  before do
    create :video, user: user
  end
  scenario 'without login' do
    visit videos_path
    expect(page).to have_content "Funny movie"
    expect(page).to have_content "shared by #{user.username}"
    expect(page).to have_selector("i.fa-thumbs-o-down", text: "0")
    expect(page).to have_selector("i.fa-thumbs-o-up", text: "0")
    expect(page).to have_selector("a", text: "Log in")
  end

  scenario 'with login' do
    visit videos_path
    expect(page).to have_selector("a", text: "Log in")

    expect(page).to have_content "Funny movie"
    expect(page).to have_content "shared by #{user.username}"
    expect(page).to have_selector("i.fa-thumbs-o-down", text: "0")
    expect(page).to have_selector("i.fa-thumbs-o-up", text: "0")

    find('a[href$="auth/new"]').click
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    click_button 'login'
    expect(page).to have_current_path(videos_path)
    expect(page).to have_content "Welcome"
    expect(page).to have_selector("nav b", text: user.username)
    expect(page).to have_selector("button", text: "Share video")
    expect(page).to have_selector("button#logout", text: "Log out")

    expect(page).to have_selector("i.fa-thumbs-o-down", text: "0")
    expect(page).to have_selector("i.fa-thumbs-o-up", text: "0")

    # like
    find("i.clickable.fa.fa-thumbs-o-up").click
    expect(page).to have_selector("i.fa-thumbs-o-up", text: "1")
    expect(page).to have_selector("i.fa-thumbs-o-down", text: "0")
    expect(page).to have_selector("i.clickable.fa-thumbs-up")

    # dislike
    find("i.clickable.fa.fa-thumbs-up").click

    expect(page).to have_selector("i.fa-thumbs-o-up", text: "0")
    expect(page).to have_selector("i.fa-thumbs-o-down", text: "1")
    expect(page).to have_selector("i.clickable.fa-thumbs-down")

  end
end