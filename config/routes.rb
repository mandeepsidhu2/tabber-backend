Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
		namespace :v1 do
			get 'get_all_chat',to: 'chat#get_all'
			post 'add_to_chat',to: 'chat#add'
			post 'filter_all',to: 'levels#filter_all'
			get 'songs', to: 'songs#get_all'
			post 'add_song', to: 'songs#add_song'
			get 'delete_song',to: 'songs#delete_song'
			get 'fetch',to: 'levels#get_user_data'
			post 'change',to: 'levels#change'
			get 'login', to: 'login#login'
			get 'ping', to: 'health#ping'
		end
	end
end
