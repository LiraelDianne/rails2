require 'rails_helper'
RSpec.describe LikesController, type: :controller do
  before do
    @user = create_user
    @secret = @user.secrets.create(content: 'a secret')
  end
  describe "when not logged in" do
    before do 
    	session[:user_id] = nil
    end
    it 'cannot like a secret' do 
    	post :create 
    	expect(response).to redirect_to('/sessions/new')
    end
    it 'cannot unlike a secret' do
    	@secret.likes.create(user: @user)
    	delete :destroy
    	expect(response).to redirect_to('/sessions/new')
    end
  end

  describe 'when signed in as the wrong user' do 
    # not sure what this is
    # all users should be able to like/unlike
    # it's impossible to like something as somebody else
    # so I am testing that you cannot like something twice
    it 'cannot double-like' do
      @user.likes.create(secret: @secret)
      session[:user_id] = @user.id
      post :create, secret: @secret.id
      expect(@secret.likes.length).to eq(1)
    end
  end
end
