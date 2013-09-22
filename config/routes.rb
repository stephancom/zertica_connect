ZerticaConnect::Application.routes.draw do	
	devise_for :users, :controllers => {:registrations => "registrations"}

	authenticated :user do
		resources :users do
			resources :messages, except: [:edit, :update, :destroy] do
				patch 'bookmark', on: :member
			end
		end
		resources :messages, except: [:edit, :update, :destroy] do
			patch 'bookmark', on: :member
		end

		resources :projects 

		get 'dashboard', to: 'home#dashboard'
	end

	root :to => "home#index"
end