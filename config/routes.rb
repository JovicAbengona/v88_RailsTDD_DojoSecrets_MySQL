Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  get 'secrets/index'
  root 'sessions#new'

  get '/sessions/new'
  get '/users/new'
  get '/users/:id' => 'users#show'
  get '/users/:id/edit' => 'users#edit'
  get '/secrets' => 'secrets#index'

  post '/session' => 'sessions#create'
  delete '/sessions/:id' => 'sessions#destroy'
  post '/users' => 'users#register'
  patch '/update/:id' => 'users#update'
  delete '/delete/:id' => 'users#delete'
  post '/secrets/:id' => 'secrets#create'
  delete '/secrets/:id' => 'secrets#delete'
  post 'likes/:id' => 'likes#create'
  delete 'likes/:id' => 'likes#destroy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
