class RideController < ApplicationController

  	#filter to allow you to process json requests
	before do

		if !session[:logged_in]
			halt 200, {
				success: false,
				message: "You are not logged in."
			}.to_json
		end

	end

  	# index route to show all rides
	get '/' do 
		@rides = Ride.all

		{
			success: true,
			message: "successfully retrieved #{@rides.length} rides",
			retrieved_rides: @rides
		}.to_json	
	end

	# show route to show one ride
	get '/:id' do
		@ride = Ride.find(params[:id])

		if @ride
			@passengers = @ride.users

			{
				success: true,
				message: "Found ride id #{@ride.id}",
				found_ride: @ride,
				passenger_ids: @passengers
			}.to_json
		else
			{
				success: false,
				message: "Could not find ride."
			}.to_json
		end
	end

	# create a new ride
	post '/' do

		@ride = Ride.new
		@ride.name = @payload[:name]
		@ride.pickup = @payload[:pickup]
		@ride.destination = @payload[:destination]
		@ride.pickup_date = @payload[:pickup_date]
		@ride.pickup_time = @payload[:pickup_time]
		@ride.driver_user_id = @payload[:driver_user_id]
		@ride.passenger_slots = @payload[:passenger_slots]

		# this creates a row in the rides_users table to add a driver record to the table 
		@driver = User.find(@payload[:driver_user_id])
		@ride.users.push(@driver)

		@ride.save

		{
			success: true,
			message: "you added ride \##{@ride.id}",
			added_ride: @ride
		}.to_json
	end

	# update passenger_slots and add passengers to ride ()
	put '/:id/adduser/:user_id' do

		@ride = Ride.find(params[:id])

		# decreases the passenger_slots number
		@ride.passenger_slots = @ride.passenger_slots - 1
		
		# creates a record in users_rides table
		@user = User.find(params[:user_id])

		@ride.users.push(@user)

		@ride.save

		{
			success: true,
			message: "you have claimed a slot in ride #{@ride.id}",
			remaining_passengers_slots: @ride.passenger_slots,
			ride_details: @ride
		}.to_json

	end

	# delete, or 'cancel', a ride - driver
	delete '/:id' do
		@ride = Ride.find params[:id]
		@ride.destroy

		@ride.users.destroy

		{
			success: true,
			message: "you deleted ride id \##{@ride.id}",
			deleted_ride: @ride
		}.to_json
	end

	# delete, or 'cancel', a ride - passenger
	delete '/:id/removeuser/:user_id' do
		@ride = Ride.find params[:id]

		# add to the passenger_slots number
		@ride.passenger_slots = @ride.passenger_slots + 1

		# finding the user id for the passenger that wants to cancel their ride slot
		@user = User.find(params[:user_id])
		@ride.users.destroy(@user)

		{
			success: true,
			message: "you deleted user #{@user.username} from ride id \##{@ride.id}",
			deleted_user: @user,
			remaining_passengers_slots: @ride.passenger_slots,
			remaining_passengers_in_ride: @ride.users,
			current_ride: @ride
		}.to_json
	end

	# edit/update a ride
	# NOTE: driver's cannot edit destination, driver's ID or pickup date
	put '/:id' do
		@rides = Ride.where(id: params[:id])

		@ride = @rides[0]

		@ride.name = @payload[:name]
		@ride.pickup = @payload[:pickup]
		@ride.pickup_time = @payload[:pickup_time]
		@ride.passenger_slots = @payload[:passenger_slots]
		@ride.save

		{
			success: true,
			message: "you updated ride id \##{@ride.id}",
			updated_ride: @ride
		}.to_json
	end
end