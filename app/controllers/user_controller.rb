class UserController < ApplicationController
  def new
  end

  def create
  	user = User.new(user_params)
    if user.save
		flash[:message] = 'You signed up!'
		redirect_to '/'
    else
    	flash[:error] = 'Need Registration info!'
		redirect_to '/'
    end
  end

  def index
  	@user = User.find(session[:user_id])
  	@mynetwork = Friendship.where(user_id: session[:user_id], network: 0)
  	@askingnetwork = Friendship.where(friend_id: session[:user_id], network: 1)
  end

  def show

# 1 = sent invite
# 2 = ignored
# 0 = accepted to network

  	@current_user = User.find(session[:user_id])
  	@users = User.all
  	@friends = Friendship.all
  	@outsidenetwork = Friendship.where(user_id: session[:user_id], network: 2)
  	@mynetwork = Friendship.find_by(user_id: session[:user_id], network: 0)
  	@askingnetwork = Friendship.find_by(friend_id: session[:user_id], network: 1)
  	@network = Friendship.all
  end

  def otherprofile
  	@otheruser = User.find(params[:id])
  end

  private

	def user_params
		params.permit(:name, :email, :password, :password_confirmation, :description)
	end
end
