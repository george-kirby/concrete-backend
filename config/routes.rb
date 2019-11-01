Rails.application.routes.draw do
  resources :steps, only: [:index, :show, :create, :update, :destroy]
  resources :tasks, only: [:index, :show, :create, :update, :destroy]
  resources :projects, only: [:index, :show, :create, :update, :destroy]
  resources :users, only: [:index, :show, :create, :update, :destroy]
  post '/login', to: 'authentication#create'
  post '/validate', to: 'authentication#validate'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
