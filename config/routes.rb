Rails.application.routes.draw do
  resources :tasks, only: [:index, :create, :update]
  root 'tasks#index'
end
