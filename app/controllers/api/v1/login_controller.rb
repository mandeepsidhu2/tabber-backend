module Api
	module V1	
		class LoginController < ApplicationController
			before_action :set_api_current_user,only: [:logout]
			def login
				validator = GoogleIDToken::Validator.new
				@id_token = request.headers["token"]
				required_audience=JWT.decode(@id_token, nil, false)[0]['aud']
				begin
		 			payload = validator.check(@id_token, required_audience, required_audience)
		 		rescue GoogleIDToken::ValidationError => e
		 			report "Cannot validate: #{e}"
				end
				@user = User.find_by(email: payload['email'])
				if @user.blank?
					@user = User.create(
							email: payload['email'],
							name:payload['name'],
							# confirmed_at: Time.now
						)
				end

				# if @user.confirmed_at.blank?
				# 	user.confirmed_at = Time.now
				# 	user.save
				# end
				puts("the user id is ",@user.id ," and token is ")
				@token=JsonWebToken.encode(user_id: @user.id)
				puts(@token)
				render 'users/login.json.jbuilder', status: 200
			end

			def logout
				@api_current_user.remove_auth_token_validity
			end
		end
	end
end
