class FriendshipController < ApplicationController
	def accept
		Friendship.update(params[:id], network: 0)
		redirect_to '/index'
	end

	def ignore
		Friendship.update(params[:id], network: 2)
		redirect_to '/index'
	end

	def connect
		target = User.find(params[:id])
		friend = Friendship.new(user_id: session[:user_id], friend_id: target.id, network: 1)
		search = Friendship.find_by(user_id: session[:user_id], friend_id: target.id)
		if search == nil
			if friend.save
				flash[:message] = 'You sent them a friend request!'
				redirect_to '/users'
			else
				flash[:error] = "They didn't receive your request. T_T"
				redirect_to '/users'
			end
		else
			flash[:error] = 'You already sent them a friend request!'
			redirect_to '/users'
		end
	end

	def remove
		friend = Friendship.find(params[:id])
		friend.destroy
		flash[:message] = 'No longer friends with them!'
		redirect_to '/index'
	end
end
