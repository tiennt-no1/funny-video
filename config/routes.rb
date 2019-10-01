Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  delete '/auth/logout', to: 'authentication#logout'
  get '/auth/new', to: 'authentication#new_session'
  get '/*a', to: 'application#not_found'


  resources 'videos', only: %i(index create new)
  root to: 'videos#index'
end
