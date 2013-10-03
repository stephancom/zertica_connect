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
			# resources :orders
		end

		resources :projects do
		  resources :assets
		  resources :project_files
		  # resources :orders
		end

		resources :orders do
			member do
				patch 'estimate'
				patch 'pay' 
				put 'complete'
				patch 'ship'
				patch 'archive'
			end
		end

		root to: 'active_chats#index', as: :admin_root
	end

	authenticated :user do

		resources :messages, except: [:edit, :update, :destroy] do
			patch 'bookmark', on: :member
		end

		resources :projects do
			resources :assets
			resources :project_files
			# resources :orders
			resources :orders#, :only => [:new, :create]
		end

		resources :orders, :except => [:new, :create] do
			patch 'pay', on: :member # probably not needed, part of payment system
		end

		root to: 'projects#index', as: :user_root
	end

	root to: 'home#index', as: :root
end