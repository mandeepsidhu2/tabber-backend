class Api::V1::ChatController < ApplicationController
	def get_all
		@chats=Chat.all
		render json: @chats,status: 200
	end
	def add
		@chats=Chat.all
		#reduce the size of the chat database
		if @chats.size>200
			@chats.each_with_index do |chat,index|
				if(index > 50)
					break
				end
				chat.destroy
			end
		end
		data=JSON.parse(request.body.read)
		Chat.create(user_id:data["userId"],name:data["name"],message:data["message"])
		render json: {"render"=>"success"}.to_json,status: 200
	end
end
