Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  delete '/auth/logout', to: 'authentication#logout'
  get '/auth/new', to: 'authentication#new_session'
  resources 'videos', only: %i(index create new) do
    member do
      put :like
      put :dislike
    end
  end
  root to: 'videos#index'
  get '/*a', to: 'application#not_found'
end
