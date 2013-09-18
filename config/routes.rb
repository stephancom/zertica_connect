ZerticaConnect::Application.routes.draw do
	root :to => "home#index"
	devise_for :users, :controllers => {:registrations => "registrations"}
	resources :users

	resources :projects do
		resources :messages, except: [:edit, :update, :destroy] do
			patch 'bookmark', on: :member
		end
	end
end