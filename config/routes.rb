ZerticaConnect::Application.routes.draw do	

	devise_for :admins, :controllers => {:registrations => "admin_registrations"}
	devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => "users/omniauth_callbacks" }

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
		  resources :project_files, except: [:edit, :update]
		  resources :orders
		end

		resources :orders, :except => [:new, :create, :edit, :update] do
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
			resources :project_files, except: [:edit, :update]
			resources :orders
		end

		resources :orders, :except => [:new, :create, :edit, :update] do
			patch 'pay', on: :member # probably not needed, part of payment system
		end

		root to: 'projects#index', as: :user_root
	end

	match 'order_confirm_payment' => 'orders#confirm_payment', :as => :order_confirm_payment, :via => :get

	root to: 'home#index', as: :root
end