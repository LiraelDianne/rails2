class LikesController < ApplicationController
  before_action :require_login

  def create
  	user = User.find(session[:user_id])
  	secret = Secret.find(params[:secret])
    unless Like.where(user: user, secret: secret).take
  	  Like.create(user: user, secret: secret)
    end
  	redirect_to url_for(controller: :secrets, action: 'index')
  end

  def destroy
  	user = User.find(session[:user_id])
  	secret = Secret.find(params[:secret])
  	Like.where(user: user, secret: secret).take.destroy 
  	redirect_to url_for(controller: :secrets, action: 'index')
  end
end
