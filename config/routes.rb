Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check
  root 'questions#index'
  
  resources :questions do
    patch 'hidden', on: :member
    put 'hidden', on: :member
  end

  resources :users, only: %i[show]
end
