class Api::V1::SongsController < ApplicationController
	def get_all
		@songs=Song.all
		render json: @songs.except("created_at","updated_at","id"),status: 200
	end
	def add_song
		data=JSON.parse(request.body.read)
		puts(data)
		@name=data["name"]
		@link=data["link"]
		@song=Song.create(name:@name,link:@link)
		render json:@song,status: 200
	end
	def delete_song
		@songs=Song.all
		@song_id=nil
		@songs.each_with_index do |song|
			if(song.name == params[:name])
				puts(@song_id)
				@song_id=song.id
				break
			end
		end
		Song.delete(@song_id)
		render json:"deleted",status: 200
	end
end
