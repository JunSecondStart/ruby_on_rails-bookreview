Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  get 'books/search', to: "books#search"
  get 'books/create', to: "books#create"
  post 'books/create', to: "books#index"
  get 'books/index', to: "books#index"
  
  resources :users, only: [:index, :show, :create]do
    member do
      get :followings
      get :followers
      get :likes
    end
  end
    resources :review, only: [:new, :create]
    resources :microposts, only: [:create, :destroy]
    resources :favorites, only: [:index, :create, :destroy]
end
