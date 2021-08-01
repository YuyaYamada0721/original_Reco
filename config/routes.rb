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
    collection do
      get :search
    end
    resources :groups, controller: 'teams/groups', only: %i[show create]
    resources :messages, controller: 'teams/messages', only: %i[create]
    resources :tags, controller: 'teams/tags', only: %i[index new create destroy]
    resources :knowledges, controller: 'teams/knowledges' do
      collection do
        get :search
      end
      resources :tips, controller: 'teams/knowledges/tips'
      resources :stocks, controller: 'teams/knowledges/stocks', only: %i[create destroy]
    end
    resources :members, controller: 'teams/members', only: %i[show create destroy] do
    end
  end
end
