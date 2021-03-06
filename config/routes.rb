Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root 'tops#index'

  get 'help', action: :index, controller: 'helps'

  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/admin_guest_sign_in', to: 'users/sessions#admin_guest_sign_in'
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
    resources :messages, controller: 'teams/messages', only: %i[create destroy]
    resources :tags, controller: 'teams/tags', only: %i[index new create destroy]
    resources :members, controller: 'teams/members', only: %i[show create destroy]
    resources :knowledges, controller: 'teams/knowledges' do
      collection do
        get :search
      end
      resources :tips, controller: 'teams/knowledges/tips' do
        collection do
          get :search
        end
      end
      resources :stocks, controller: 'teams/knowledges/stocks', only: %i[create destroy]
    end
  end
end
