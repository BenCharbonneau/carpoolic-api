class ApplicationController < Sinatra::Base
	require 'bundler'
	Bundler.require()

	ActiveRecord::Base.establish_connection(
		:adapter => 'postgresql',
		:database => 'carpoolic',
		:pool => 20
	)

	# added for CORS
	register Sinatra::CrossOrigin

	  configure do
	    enable :cross_origin
	  end

	use Rack::Session::Cookie, :key => 'rack.session',
							   :path => '/',
							   :secret => 'garden'

	# filter to allow JSON requests to be processed
  	before do

    	payload_body = request.body.read

    	if(payload_body != "")
    	  @payload = JSON.parse(payload_body).symbolize_keys
    	end
  	end

  	#CORS
	set :allow_origin, :any # you can specifiy origins here, we'll just say any
	set :allow_methods, [:get, :post, :options, :put, :patch, :delete]
	set :allow_credentials, true # session info / API key enable

	options '*' do
	    response.headers['Allow'] = 'HEAD, GET, POST, PUT, PATCH, DELETE'
	    response.headers['Access-Control-Allow-Origin'] = 'http://localhost:3000'
	    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
	end
	# END OF CORS

	get '/' do
		{
			success: false,
			message: "Please consult the API documentation"
		}.to_json
	end

	not_found do
		halt 404, {
			success: false,
			message: "404 - Page not found"
		}.to_json
	end
end
