class Api::V1::SongsController < ApplicationController
	def get_all
		@songs=Song.all
		render json: @songs.except("created_at","updated_at","id"),status: 200
	end
end
