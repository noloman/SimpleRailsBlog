Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :registrations, only: [:new, :create]
  resources :logins, only: [:new, :create]
  # resources :posts
  root 'posts#index'
end
