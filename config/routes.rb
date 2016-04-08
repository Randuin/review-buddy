Rails.application.routes.draw do
  devise_for :user

  resource :graphql, controller: 'graphql'
  if Rails.env.development? || Rails.env.test?
    get '/graphql/introspection', to: 'graphql#introspection'
  end

  post '/webhooks/comment', to: 'webhooks#comment'
  post '/webhooks/pr', to: 'webhooks#pr'
  get '/oauth/github', to: 'oauth#github'
end
