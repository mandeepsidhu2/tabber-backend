require 'json_web_token'
class ApplicationController < ActionController::API
	  include ActionController::HttpAuthentication::Token::ControllerMethods

	def set_api_current_user
		@date=Date.today.in_time_zone('Kolkata').strftime("%Y-%m-%d").to_s;
		header=request.headers["token"]
		 puts("date is ",@date)
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