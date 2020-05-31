class Api::V1::UserController < ApplicationController
	def delete_user
		puts(params[:email])
		User.where(email:params[:email]).destroy_all
		render json: {"deleted"=>"success"}.to_json,status: 200
	end
end
