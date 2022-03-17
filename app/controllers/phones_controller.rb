class PhonesController < ApplicationController
	before_action :generateNumber ,only:[:create]
	def index
		@numbers = PhoneNumber.all.select(:id,:phoneNumber)
		render json:{ success: true, alloted_phone_numbers:@numbers}, status: 200
	end

	def create
		@phoneNumber = PhoneNumber.new(phoneNumber:@generated_number)
		if @phoneNumber.save
			render json:{ success: true,message:"#{@phoneNumber.phoneNumber} is allocated successfully.", alloted_phone_number:@phoneNumber.phoneNumber}, status: 200
		else
	        render json: { success: false, errors: 'An error occurred'},status: :unprocessable_entity
		end
	end

	def fancyNumbersCreate
		 fancy_numbers = params[:number] 
		 if PhoneNumber.exists?(phoneNumber: fancy_numbers)
		 	generateNumber
 			@phoneNumber = PhoneNumber.new(phoneNumber:@generated_number)
			if @phoneNumber.save
				render json:{ success: true,message:"Requested number is not available so #{@phoneNumber.phoneNumber} is allocated successfully.", alloted_phone_numbers:@phoneNumber.phoneNumber}, status: 200
			else
		        render json: { success: false, errors: 'An error occurred'},status: :unprocessable_entity
			end
		 else
		 	@phoneNumber = PhoneNumber.new(phoneNumber:fancy_numbers)
		 	if @phoneNumber.valid?
			 	if @phoneNumber.save
					render json:{ success: true,message:"Requested number #{fancy_numbers} is allocated successfully.", alloted_phone_numbers:@phoneNumber.phoneNumber}, status: 200
				else
			        render json: { success: false, errors: 'An error occurred'},status: :unprocessable_entity
				end
			else
				render json: { success: false, errors: @phoneNumber.errors[:phoneNumber]},status: :unprocessable_entity
			end
		 end
	end

	private

	def generateNumber
	  @generated_number = loop do
	    number = rand(1111111111...9999999999)
	    break number unless PhoneNumber.exists?(phoneNumber: number)
	  end
	end
end
