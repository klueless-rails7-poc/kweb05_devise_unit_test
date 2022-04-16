Rails.application.routes.draw do
  resources :posts
  get 'home/index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: 'posts#index'
end
