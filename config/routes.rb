Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root 'tops#index'

  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :users, only: %i[show edit update]
  resources :teams do
    member do
      patch :owner_change
    end
    resources :knowledges, controller: 'teams/knowledges' do
      resources :stocks, controller: 'teams/knowledges/stocks', only: %i[create destroy]
      resources :tips, controller: 'teams/knowledges/tips' do
        resources :tags, controller: 'teams/knowledges/tips/tags', only: %i[index new create destroy]
      end
    end
    resources :members, controller: 'teams/members', only: %i[create destroy] do
    end
  end
end
