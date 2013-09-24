ZerticaConnect::Application.routes.draw do	
	devise_for :admins, :controllers => {:registrations => "admin_registrations"}
	devise_for :users, :controllers => {:registrations => "registrations"}

	authenticated :admin do
		resources :users do
			resources :messages, except: [:edit, :update, :destroy] do
				patch 'bookmark', on: :member
			end
		end

		resources :projects 

		root to: 'home#dashboard', as: :admin_root
	end

	authenticated :user do
		resources :messages, except: [:edit, :update, :destroy] do
			patch 'bookmark', on: :member
		end

		resources :projects 

		root to: 'projects#index', as: :user_root
	end

	root to: 'home#index', as: :root
end