class Api::V1::PostsController < ApplicationController
	before_action :set_api_current_user, except: :filter_all

	def create
		data=JSON.parse(request.body.read)
		title=data["title"]
		content=data["content"]
		@post=Post.create(title:title,content:content,user_id:@api_current_user.id)
		render json:@post,status: 200
	end
	def get
		@posts=Post.all
		@posts_collect= Array.new
		@posts.each_with_index do |post|
			tempPost=Object.new
			class << tempPost
				attr_accessor :id
				attr_accessor :title
				attr_accessor :content 
				attr_accessor :username 
				attr_accessor :picture_url
				attr_accessor :email
				attr_accessor :likes
				attr_accessor :is_liked
			end
			tempUser= User.find(post.user_id)
			tempPost.id=post.id
			tempPost.title=post.title
			tempPost.content=post.content
			tempPost.username=tempUser.name
			tempPost.picture_url=tempUser.photo_url
			tempPost.likes=post.likes.size
			tempPost.is_liked=Like.where(post_id:post.id,user_id:@api_current_user.id).present?
			@posts_collect.push(tempPost)
		end
		render json:@posts_collect,status: 200
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
