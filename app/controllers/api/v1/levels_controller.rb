require 'json'
class Api::V1::LevelsController < ApplicationController
	before_action :set_api_current_user
	def change
		
		@user=User.find_by email: @api_current_user.email 
		data=JSON.parse(request.body.read)
		level=data["level"]
		completed=data["completed"]
		data=@user[level]
		puts(data)
		data.each_with_index do |item,index|
    		var=JSON.parse(item)
    		@index=index
    		if(var[0]["time"].eql?(Date.today.to_s))
    			puts("*****************")
    			puts(index)
    			
    			data.delete_at(index)
    			var = [{
		  			completed: completed,
		 	 		time: Date.today
				}].to_json
			@user[level] << var
			@user.save
			puts(@user[level])
			puts("*****************")
			break
    		end
		end

		render 'levels/change.json.jbuilder', status: 200
	end

	def get_user_data
		@user=User.find_by email: @api_current_user.email 
		
		#data=JSON.parse(@user.easy);
		data=@user.easy
		@varEasy=nil
		@varMedium=nil
		@varDifficult=nil
		@index=0
		data.each_with_index do |item,index|
    		@varEasy=JSON.parse(item)
    		@index=index
    		if(@varEasy[0]["time"].eql?(Date.today.to_s))
    			break
    		else
    			@varEasy=nil
    		end
		end
		if @varEasy==nil
			@varEasy = [{
		  	completed: 0,
		 	 time: Date.today
			}].to_json
			@user.easy << @varEasy
			@user.medium << @varEasy
			@user.difficult << @varEasy
			@user.save
			@varEasy=JSON.parse(@varEasy)
		end
			
			@varEasy=@varEasy[0]["completed"]
			@varMedium=JSON.parse(@user.medium[@index])
			@varMedium=@varMedium[0]["completed"]
			@varDifficult=JSON.parse(@user.difficult[@index])
			@varDifficult=@varDifficult[0]["completed"]
			
		
		
		render 'levels/userdata.json.jbuilder', status: 200

	end

end
