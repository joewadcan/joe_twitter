class SessionsController < ApplicationController

	def new


	end

	def create
		user = User.find_by_email(params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			then
			sign_in user
      		redirect_back_or user
		else
			flash.now[:error] = 'Invalid email and/or password combo. Try again homie'
			render 'new'

		end
	end

	def destroy
    	sign_out
    	redirect_to root_url
  	end
	
end
