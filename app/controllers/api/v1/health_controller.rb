class Api::V1::HealthController < ApplicationController
	def ping
		render json: "pong",status:200
	end
end
