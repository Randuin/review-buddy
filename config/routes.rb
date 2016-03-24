Rails.application.routes.draw do
  devise_for :user

  resource :graphql, controller: 'graphql'

  post '/webhooks/comment', to: 'webhooks#comment'
  get '/oauth/github', to: 'oauth#github'
end
