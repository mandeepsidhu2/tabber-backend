require 'json_web_token'
class ApplicationController < ActionController::API
	  include ActionController::HttpAuthentication::Token::ControllerMethods


	def set_api_current_user
		header=request.headers["token"]
		 puts("token is ",header)
		begin
		 @decoded = JsonWebToken.decode(header)
		 @api_current_user = User.find(@decoded[:user_id])

		 rescue ActiveRecord::RecordNotFound => e
		
      render json: { errors: e.message }, status: :unauthorized
	end
	 rescue JWT::DecodeError => e
	 	
      render json: { errors: e.message }, status: :unauthorized
    end

	
end