require 'rails_helper'
RSpec.describe 'updating user' do
  it 'updates user and redirects to profile page' do
    user = create_user
    log_in user
    expect(page).to have_text('crystal')
    click_link 'Edit Profile'
    fill_in 'user[name]', with: 'dianne'
    fill_in 'user[email]', with: 'dianne@emails.com'
    click_button 'Update'
    expect(page).not_to have_text('crystal')
    expect(page).to have_text('dianne')
  end
  it 'displays errors when update fails' do 
    user = create_user
    log_in user
    expect(page).to have_text('crystal')
    click_link 'Edit Profile'
    fill_in 'user[name]', with: ''
    click_button 'Update'
    expect(page).to have_text("can't be blank")
    expect(current_path).to eq("/users/#{user.id}/edit")
  end
end