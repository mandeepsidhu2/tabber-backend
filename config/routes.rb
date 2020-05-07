Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
		namespace :v1 do
			get 'all', to: 'levels#get_all_data'
			get 'fetch',to: 'levels#get_user_data'
			post 'change',to: 'levels#change'
			get 'login', to: 'login#login'
		end
	end
end
