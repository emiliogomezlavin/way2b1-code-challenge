Rails.application.routes.draw do
  resources :users
  
  root 'users#home'
  post '/get_user_details', to: 'users#get_user_details', as: 'get_user_details'
  
end
