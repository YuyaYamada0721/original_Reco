Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root 'application#top'

  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :users, only: %i[show edit update]
  resources :teams do
    member do
      patch :owner_change
    end
    resources :members, controller: 'teams/members' do
    end
    resources :knowledges, controller: 'teams/knowledges' do
      resources :tips, controller: 'teams/knowledges/tips'
    end
  end
end
