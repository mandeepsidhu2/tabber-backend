require 'json'
class Api::V1::LevelsController < ApplicationController
	def cnt(arr)
		total=0
		arr.each do |var|
			var=JSON.parse(var)
			total+=var[0]["completed"]
		end
		return total
	end
	before_action :set_api_current_user
	def size
		render json: User.all.size,status: 200
	end
	def filter_all
		puts(request.body.read)
		@tableData=JSON.parse(request.body.read)
		initials=@tableData["emailInitials"].downcase
		tablePageIndex=@tableData["pageIndex"]
		tablePageSize=@tableData["pageSize"]
		@users=User.all
		@newArr=[]
		@users.each_with_index do |user,index|
			var=user
			user=user.attributes
			user['totalEasy']=cnt(var.easy)
			user['totalMedium']=cnt(var.medium)
			user['totalDifficult']=cnt(var.difficult)
			@newArr.push(user.except("created_at","updated_at","id"))
		end
		
		@ans=[]
		@newArr.each do |user| 
			@ans << user if user['email'].include?initials;
		 	@ans << user if user['name'].downcase.include?initials;
		end

		@ans=@ans.uniq
		@ans=@ans.slice(tablePageSize*tablePageIndex,tablePageSize)
		logger.debug "Rendering data for dashboard table:#{@ans}"
		render json:@ans,status: 200
	end

	def get_all_data
		@tableData=JSON.parse(request.body.read)
		tablePageIndex=@tableData["pageIndex"]
		tablePageSize=@tableData["pageSize"]
		@users=User.all
		@newArr=[]
		@users.each_with_index do |user,index|
			var=user
			user=user.attributes
			user['totalEasy']=cnt(var.easy)
			user['totalMedium']=cnt(var.medium)
			user['totalDifficult']=cnt(var.difficult)
			@newArr.push(user.except("created_at","updated_at","id"))
		end
		@newArr=@newArr.slice(tablePageSize*tablePageIndex,tablePageSize)
		logger.debug "Rendering data for dashboard table:#{@newArr}"
		render json: @newArr, status: 200
	end
	def change
		
		@user=User.find_by email: @api_current_user.email 
		data=JSON.parse(request.body.read)
		logger.debug "Data to be updated_at to:#{data},on #{@date}"
		level=data["level"]
		completed=data["completed"]
		data=@user[level]
		logger.debug "Previous data for the level:#{level} is #{data}"
		data.each_with_index do |item,index|
    		var=JSON.parse(item)
    		@index=index
    		if(var[0]["time"].eql?(@date))
    		logger.debug "Updating for level #{level},on #{@date},completed:#{completed}"
    			data.delete_at(index)
    			var = [{
		  			completed: completed,
		 	 		time: @date
				}].to_json
			@user[level] << var
			@user.save
			puts(@user[level])
			
			break
    		end
		end

		render 'levels/change.json.jbuilder', status: 200
	end

	def get_user_data
		@user=User.find_by email: @api_current_user.email 
		logger.debug "Rendering for user :#{@user.email},on #{@date}"
		data=@user.easy
		logger.debug "Previous data for easy level:#{data}"
		@varEasy=nil
		@varMedium=nil
		@varDifficult=nil
		@index=0
		data.each_with_index do |item,index|
    		@varEasy=JSON.parse(item)
    		@index=index
    		if(@varEasy[0]["time"].eql?(@date))
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
			@index=@user.easy.size-1
			@varEasy=JSON.parse(@varEasy)
			logger.debug "New day entry for user :#{@user.email}"
		end
	
			@varEasy=@varEasy[0]["completed"]
			@varMedium=JSON.parse(@user.medium[@index])
			@varMedium=@varMedium[0]["completed"]
			@varDifficult=JSON.parse(@user.difficult[@index])
			@varDifficult=@varDifficult[0]["completed"]

		logger.debug "Entry for easy :#{@varEasy}, medium :#{@varMedium} , difficult :#{@varDifficult}"
		render 'levels/userdata.json.jbuilder', status: 200

	end

end
