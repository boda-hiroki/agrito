Rails.application.routes.draw do
  post 'comments/create', to: 'comments#create'
  get 'comments/:id/new', to: 'comments#new'
  
  get 'posts/index', to: 'posts#index'
  get 'posts/new', to:'posts#new'
  post 'posts/create', to: 'posts#create'
  get 'posts/:id/edit', to: 'posts#edit'
  post 'posts/:id/update', to: 'posts#update'
  delete 'posts/:id/destroy', to: 'posts#destroy'
  
  get 'posts/:id', to: 'posts#show'
  
  
  
  get 'sessions/new'
  get 'users/new'
  get 'pages/index'
  root 'pages#index'
  
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users
  resources :relationships, only:[:create, :destroy]
  get 'users/:id', to: 'users#show'
  
  mount ActionCable.server => '/cable'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
