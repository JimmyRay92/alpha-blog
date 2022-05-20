Rails.application.routes.draw do
  devise_for :users
  root to: 'teachers#index'
  get 'about', to: 'pages#about'

  resources :teachers
end
