Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root 'users#show'

  devise_for :users

  resources :users, only: %i[show edit update]

end
