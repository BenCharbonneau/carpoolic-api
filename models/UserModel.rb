class User < ActiveRecord::Base
	# has_secure_password

	has_many :ride_slots
	has_many :rides, :through => :ride_slots
end