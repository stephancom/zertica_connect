ZerticaConnect::Application.routes.draw do	
	devise_for :admins, :controllers => {:registrations => "admin_registrations"}
	devise_for :users, :controllers => {:registrations => "registrations"}

	authenticated :admin do
		resources :active_chats, except: [:edit, :update, :new]

		resources :messages, only: [] do
			patch 'bookmark', on: :member
		end
		resources :users do
			resources :messages, except: [:edit, :update, :destroy] do
				patch 'bookmark', on: :member
			end
		end

		resources :projects do
		  resources :assets
		end

		root to: 'active_chats#index', as: :admin_root
	end

	authenticated :user do
		resources :messages, except: [:edit, :update, :destroy] do
			patch 'bookmark', on: :member
		end

		resources :projects do
			resources :assets
		end

		root to: 'projects#index', as: :user_root
	end

	root to: 'home#index', as: :root
end