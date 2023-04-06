Rails.application.routes.draw do
  get 'users/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  #all the necessary routes
  resources :users
  resources :reimbursements
end
