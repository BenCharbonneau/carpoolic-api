require 'sinatra/base'
require 'sinatra/activerecord'

# controllers
require './controllers/ApplicationController'
require './controllers/RideController'
# require './controllers/RideSlotController'

# models
require './models/RideModel'
# require './models/RideSlotModel'


#  mapping controllers to routes
map ('/') {
	run ApplicationController
}

map ('/rides') {
	run RideController
}

# map ('/rideslot') {
# 	run RideSlotController
# }