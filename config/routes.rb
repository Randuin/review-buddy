Rails.application.routes.draw do
  resource :graphql, controller: 'graphql'
  get '/oauth/github', to: 'oauth#github'
end
