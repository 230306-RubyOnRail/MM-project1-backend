Rails.application.routes.draw do
  get 'sessions/create'
  get 'sessions/destroy'
  get 'users/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  #all the necessary routes
  post '/auth/login', to: 'sessions#create'
  resources :users
  resources :reimbursements
end
