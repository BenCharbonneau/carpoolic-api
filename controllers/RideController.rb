class RideController < ApplicationController

	# filter to allow JSON requests to be processed
  	before do

    	payload_body = request.body.read

    	if(payload_body != "")
    	  @payload = JSON.parse(payload_body).symbolize_keys

    	  puts "-----------------------------------------------HERE IS OUR PAYLOAD"
    	  pp @payload
    	  puts "-----------------------------------------------------------------"
    	end
  	end

  	# index route to show all rides
	get '/' do 
		@rides = Ride.all
		@rides.to_json

		{
			success: true,
			message: "successfully retrieved #{@rides.length} rides",
			retrieved_rides: @rides
		}.to_json	
	end

	# show route to show one ride
	get '/:id' do
		@ride = Ride.find(params[:id])
		{
			success: true,
			message: "Found ride id #{@ride.id}",
			found_ride: @ride
		}.to_json
	end

	post '/' do
		pp params

		@ride = Ride.new
		@ride.name = @payload[:name]
		@ride.pickup = @payload[:pickup]
		@ride.destination = @payload[:destination]
		@ride.pickup_date = @payload[:pickup_date]
		@ride.pickup_time = @payload[:pickup_time]
		@ride.driver_user_id = @payload[:driver_user_id]
		@ride.passenger_slots = @payload[:passenger_slots]
		@ride.save

		{
			success: true,
			message: "you added ride \##{@ride.id}",
			added_ride: @ride
		}.to_json
	end

	delete '/:id' do
		@ride = Ride.find params[:id]
		@ride.destroy

		{
			success: true,
			message: "you deleted ride id \##{@ride.id}",
			deleted_ride: @ride
		}.to_json
	end


end