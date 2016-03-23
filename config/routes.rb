Rails.application.routes.draw do
  devise_for :user
  resource :graphql, controller: 'graphql'
  get '/oauth/github', to: 'oauth#github'
end
