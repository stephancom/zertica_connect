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

		root to: 'home#dashboard', as: :authenticated_root
	end

	root to: 'home#index', as: :root
end