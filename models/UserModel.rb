class User < ActiveRecord::Base
	# has_secure_password
	self.skip_time_zone_conversion_for_attributes = [:written_on]
	has_and_belongs_to_many :rides
end