Rails.application.routes.draw do
  root 'application#top'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
