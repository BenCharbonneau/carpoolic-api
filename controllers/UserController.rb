class UserController < ApplicationController
	get '/' do
		@users = User.all
		@users.to_json
	end

	get '/:id/rides' do
		@user = User.find(params[:id])
		@rides = @user.rides
		
		# binding.pry
		
		@rides.to_json
	end

	post '/' do
		payload_body = request.body.read
		payload = JSON.parse(payload_body).symbolize_keys

		@user = User.new
		@user.username = payload[:username]
		@user.password = payload[:password]
		@user.email = payload[:email]

		@user.to_json
	end

	# update user account information
	put '/:id' do
		@users = User.where(id: params[:id])
		@user = @users[0]

		@user.password = @payload[:password]
		@user.email = @payload[:email]
		@user.username = @payload[:username]

		{
			success: true,
			message: "you updated user #{@user.username}'s information",
			updated_user: @user
		}

	end

	# delete a user account 
	delete '/:id' do
		@user = User.find params[:id]
		@user.destroy

		{
			success: true,
			message: "you destroyed the user #{@user.username}"
		}.to_json
	end


end