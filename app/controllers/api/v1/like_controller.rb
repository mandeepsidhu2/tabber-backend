class Api::V1::LikeController < ApplicationController
	before_action :set_api_current_user, except: :filter_all
	def like_unlike
		user_id=@api_current_user.id
		post_id=params[:post_id]
		puts("******")
		puts(user_id)
		puts(post_id)
		if Like.where(user_id:user_id,post_id:post_id).present?
			like=Like.where(user_id:user_id,post_id:post_id)[0]
			Like.delete(like.id)
		else
			Like.create(user_id:user_id,post_id:post_id)
		end
		render json:{'like_unlike':'success'},status: 200
	end
end
