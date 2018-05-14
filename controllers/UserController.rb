class UserController < ApplicationController
	get '/' do
		@users = User.all
		@users.to_json
	end

	# update user account information
	put '/:id' do
		@users = User.where(id: params[:id])
		@user = @users[0]

		@user.password = @payload[:password]
		@user.email = @payload[:email]
		@user.username = @payload[:username]

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