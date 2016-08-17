require 'rails_helper'
RSpec.describe 'user profile page' do
  before do
    @user = create_user
    log_in @user
  end
  it "displays a user's secrets on profile page" do
    secret = @user.secrets.create(content: 'my secret')
    visit "/users/#{@user.id}"
    expect(page).to have_text("#{secret.content}")
  end
  it "displays everyone's secrets" do
    user2 = create_user 'julius', 'julius@lakers.com'
    secret1 = @user.secrets.create(content: 'secret')
    secret2 = user2.secrets.create(content: 'another secret')
    visit '/secrets'
    expect(page).to have_text(secret1.content)
    expect(page).to have_text(secret2.content)
  end
  it 'hides delete button from other users' do 
    secret = @user.secrets.create(content: 'a secret')
    visit '/secrets'
    expect(page).to have_text("Delete")
    user2 = create_user 'julius', 'julius@lakers.com'
    log_in user2
    visit '/secrets'
    expect(page).to have_text(secret.content)
    expect(page).not_to have_text('Delete')
  end
end