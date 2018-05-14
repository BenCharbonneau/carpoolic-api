require 'sinatra/base'
require 'sinatra/activerecord'

# controllers
require './controllers/ApplicationController'
require './controllers/RideController'
require './controllers/UserController'

# models
require './models/RideModel'
require './models/UserModel'


#  mapping controllers to routes
map ('/') {
	run ApplicationController
}

map ('/rides') {
	run RideController
}

map ('/users') {
	run UserController
}