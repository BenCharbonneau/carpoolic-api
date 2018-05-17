class UserController < ApplicationController

	get '/' do
		if !session[:logged_in]
			halt 200, {
				success: false,
				message: "You are not logged in."
			}.to_json
		end

		@users = User.all
		
		{
			success: true,
			message: "Successfully got users.",
			users: @users
		}.to_json
	end

	get '/logout' do
		username = session[:username]

		session.destroy

		{
			success: true,
			message: "Successfully logged out."
		}.to_json
	end

	get '/:id' do
		if !session[:logged_in]
			halt 200, {
				success: false,
				message: "You are not logged in."
			}.to_json
		end

		@user = User.find(params[:id])
		
		{
			success: true,
			message: "Successfully got #{@user.username}.",
			user: @user
		}.to_json
	end

	get '/:id/rides' do
		if !session[:logged_in]
			halt 200, {
				success: false,
				message: "You are not logged in."
			}.to_json
		end

		@user = User.find(params[:id])
		@rides = @user.rides
		
		{
			success: true,
			message: "Successfully found rides for #{@user.username}.",
			rides: @rides
		}.to_json
	end

	post '/register' do
		@user = User.find_by username: @payload[:username]

		if !@user
			@user = User.new
			@user.username = @payload[:username]
			@user.password = @payload[:password]
			@user.email = @payload[:email]
			@user.save

			session[:logged_in] = true
			session[:username] = @user.username
			session[:user_id] = @user.id

			{
				success: true,
				message: "Successfully registered as #{@user.username}.",
				username: @user.username,
				user_id: @user.id
			}.to_json
		else
			{
				success: false,
				message: "Failed to create an account. Try using a different username."

			}.to_json
		end
	end

	post '/login' do
		@user = User.find_by username: @payload[:username]
		password = @payload[:password]

		if @user && @user.authenticate(password)

			session[:logged_in] = true
			session[:username] = @user.username
			session[:user_id] = @user.id

			{
				success: true,
				message: "Successfully logged in as #{@user.username}.",
				username: @user.username,
				user_id: @user.id
			}.to_json

		else

			{
				success: false,
				message: "Invalid username and password."
			}.to_json

		end
	end

	# update user account information
	put '/:id' do
		if !session[:logged_in]
			halt 200, {
				success: false,
				message: "You are not logged in."
			}.to_json
		end

		@user = User.find(params[:id])

		if @payload[:password].length > 0
			@user.password = @payload[:password]
		end
		@user.email = @payload[:email]
		@user.username = @payload[:username]

		@user.save

		{
			success: true,
			message: "you updated user #{@user.username}'s information",
			updated_user: @user
		}.to_json
	end

	# delete a user account 
	delete '/:id' do
		if !session[:logged_in]
			halt 200, {
				success: false,
				message: "You are not logged in."
			}.to_json
		end
		
		@user = User.find params[:id]

		puts "1"
		pp @user.rides

		@user.rides.each do |ride|
			ride.destroy
		end

		puts "2"
		pp @user.rides

		@user.destroy

		{
			success: true,
			message: "you destroyed the user #{@user.username}"
		}.to_json
	end


end