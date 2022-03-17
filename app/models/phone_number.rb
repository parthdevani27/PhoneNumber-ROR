class PhoneNumber < ApplicationRecord
	validates :phoneNumber, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1111111111, less_than_or_equal_to: 9999999999}
	validates_length_of :phoneNumber, is: 10,  message: "Phone number must be 10 digit long" 
end
