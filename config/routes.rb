Rails.application.routes.draw do
  devise_for :users
  resource :graphql, controller: 'graphql'
end
