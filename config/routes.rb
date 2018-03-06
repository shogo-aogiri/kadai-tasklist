Rails.application.routes.draw do

  get 'favorites/create'

  get 'favorites/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'toppages/index'

  root to: "toppages#index"
  
  resources :tasks
  get 'signup', to: 'users#new'
  resources :users, only:[:index, :show, :new, :create]
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
end
