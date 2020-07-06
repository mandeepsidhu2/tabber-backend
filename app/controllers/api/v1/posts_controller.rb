class Api::V1::PostsController < ApplicationController
	before_action :set_api_current_user, except: :filter_all

	def create
		data=JSON.parse(request.body.read)
		title=data["title"]
		content=data["content"]
		@post=Post.create(title:title,content:content,user_id:@api_current_user.id)
		render json:@post,status: 200
	end
	def delete
		@post=Post.find(params[:post_id])
		if @post.user_id == @api_current_user.id
			Post.delete(params[:post_id])
		else
			raise StandardError.new "cannot delete someones else post"
		end
		render json:"deleted",status: 200
	end
end
