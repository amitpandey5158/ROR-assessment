Rails.application.routes.draw do
  get 'news/show'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :posts do
    resources :comments, only: [:create]
  end
  resource :likes, only: [:create, :destroy]
  root 'posts#index'
  get '/news', to: 'news#show'
end
