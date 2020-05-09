module Api
	module V1	
		class LoginController < ApplicationController
			before_action :set_api_current_user,only: [:logout]
			def login
				puts("Step *****1")
				validator = GoogleIDToken::Validator.new
				@id_token = request.headers["token"]
				required_audience=JWT.decode(@id_token, nil, false)[0]['aud']
				puts("Step ******2")
				begin
					puts("Step ******3")
		 			payload = validator.check(@id_token, required_audience, required_audience)
		 			puts("Step ******4")
		 		rescue GoogleIDToken::ValidationError => e
		 			report "Cannot validate: #{e}"
				end
				puts("Step ******5")
				@user = User.find_by(email: payload['email'])
				if @user.blank?
					puts("Step ******6")
					@user = User.create(
							email: payload['email'],
							name:payload['name'],
							# confirmed_at: Time.now
						)
				end
				puts("Step ******7")
				# if @user.confirmed_at.blank?
				# 	user.confirmed_at = Time.now
				# 	user.save
				# end
				puts("the user id is ",@user.id ," and token is ")
				@token=JsonWebToken.encode(user_id: @user.id)
				puts(@token)
				puts("Step ******8")
				render 'users/login.json.jbuilder', status: 200
			end

			def logout
				@api_current_user.remove_auth_token_validity
			end
		end
	end
end
