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


end