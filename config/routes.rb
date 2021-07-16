Rails.application.routes.draw do
  devise_for :users
  root 'application#top'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
