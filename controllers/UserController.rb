class UserController < ApplicationController
	get '/' do
		@users = User.all
		@users.to_json
	end

end