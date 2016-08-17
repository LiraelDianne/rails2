class SecretsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]

  def index
  	@secrets = Secret.all
  end

  def create
  	secret = Secret.new(secret_params)
  	user = User.find(session[:user_id])
  	if secret.valid? 
  		user.secrets.create(secret_params)
  		redirect_to url_for(controller: :users, action: 'show', id: session[:user_id]) 
  	else 
  		flash[:errors] = secret.errors.full_messages
  		redirect_to url_for(controller: :users, action: 'show', id: session[:user.id]) 
  	end
  end

  def destroy
    secret = Secret.find(params[:id])
  	secret.destroy if current_user == secret.user 
  	redirect_to url_for(controller: :users, action: 'show', id: session[:user_id]) 
  end

  private 
  def secret_params 
  	params.require(:secret).permit(:content)
  end
end
