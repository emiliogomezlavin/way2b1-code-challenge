json.extract! user, :id, :name, :email, :bio, :public_repos, :followers, :following, :profile_pic, :created_at, :updated_at
json.url user_url(user, format: :json)