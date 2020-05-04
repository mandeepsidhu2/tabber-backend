require 'json'
class Api::V1::LevelsController < ApplicationController
	before_action :set_api_current_user
	def increase_easy
		puts("*****************")
		# @user=User.find_by email: @api_current_user.email 
		# new_option = [{
		#   completed: 8,
		#   time: Date.today
		# }].to_json

		# @user.easy << new_option
		# @user.save

		# puts(@user.easy)
		puts(request.body.read)
		puts("*****************")

		render 'levels/test.json.jbuilder', status: 200
	end

end
