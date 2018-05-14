class Ride < ActiveRecord::Base
	has_many :ride_slots
	has_many :users, :through => :ride_slots
end