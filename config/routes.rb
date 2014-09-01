Rails.application.routes.draw do
  root 'games#index'
  resources :frames
  resources :games
end
