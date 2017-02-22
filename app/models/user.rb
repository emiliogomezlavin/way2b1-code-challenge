class User < ApplicationRecord

	def self.create_new_user(url)
		new_user = User.get_github_info(url)
		@user = User.new()
		@user["name"] = new_user["name"]
		@user["email"] = new_user["email"]
		@user["bio"] = new_user["bio"]
		@user["public_repos"] = new_user["public_repos"]
		@user["followers"] = new_user["followers"]
		@user["following"] = new_user["following"]
		@user["profile_pic"] = new_user["avatar_url"]
		@user["github_url"] = new_user["html_url"]
		@user.save
		return @user	
	end 

	def self.get_github_info (github_user)
		github_username = User.parse_github_username(github_user)
		response = HTTParty.get('https://api.github.com/users/' + github_username)
		return response
	end

	def self.parse_github_username (obj)
		temp_array = obj["github_url"].split('/')
		username = temp_array[temp_array.length - 1]
		return username
	end
	
end
