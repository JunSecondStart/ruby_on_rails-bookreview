Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  get 'books/index', to: "books#index"
  get 'books/search', to: "books#search"
  get 'books/new', to: "books#new"
  post 'books/new', to: "review1s#create"
  post 'books/create', to: "books#create"
  get 'books/index', to: "books#index"
  
  get 'review1s/book_review1s', to: "review1s#book_review1s"
  get 'review1s/personal_review1s', to: "review1s#personal_review1s"
  get 'review1s/my_review1s', to: "review1s#my_review1s"
  
  delete 'review1s/destroy:id', to: 'review1s#destroy'
  
  get 'microposts/followings', to: 'microposts#followings'
  
  resources :users, only: [:index, :show, :create]do
    member do
      get :followings
      get :followers
      get :likes
      get :review1s
    end
  end
    resources :review1s,only: [:index, :create, :destroy, :edit, :update]
    resources :relationships, only: [:create, :destroy]
    resources :favorites, only: [:index, :create, :destroy]
end
