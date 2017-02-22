class User < ApplicationRecord

	def self.create_new_user(url)
		new_user = User.get_github_info(url)
		@user = User.new()
		@user["username"] = new_user["login"]
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

	# Fetches Github information from API of URL provided
	def self.get_github_info (github_user)
		github_username = User.parse_github_username(github_user)
		response = HTTParty.get('https://api.github.com/users/' + github_username)
		return response
	end

	# recover Github username from URL provided
	def self.parse_github_username (obj)
		temp_array = obj["github_url"].split('/')
		username = temp_array[temp_array.length - 1]
		return username
	end

	# Fetches user repos from Github API	
	def self.get_user_repos(user)
		repo_tracker = true
		page_number = 1
		repos = []
		while repo_tracker do
			page_repos = HTTParty.get('https://api.github.com/users/' + user.username + "/repos?per_page=100&page=#{page_number}")
			if page_repos === []
				repo_tracker = false
			else
				(repos << page_repos).flatten!
				page_number += 1
			end
		end
		repos.each do |repo|
			user.repos_array.push(repo["name"])
			user.save
		end
	end
	
end
