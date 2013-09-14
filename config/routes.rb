ZerticaConnect::Application.routes.draw do
  resources :projects

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end