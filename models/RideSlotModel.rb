class RideSlot < ActiveRecord::Base
	belongs_to :users
	belongs_to :rides
end