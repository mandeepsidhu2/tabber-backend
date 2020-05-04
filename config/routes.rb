Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
		namespace :v1 do
			post 'increase_easy',to: 'levels#increase_easy'
			get 'login', to: 'login#login'
		end
	end
end
