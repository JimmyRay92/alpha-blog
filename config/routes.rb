Rails.application.routes.draw do
  root to: 'teachers#index'
  devise_for :users
  resources :teachers
  get '/student_view', to: 'users#student_view', as: 'student_view'
  get '/teacher_view', to: 'users#teacher_view', as: 'teacher_view'
  get "/payments/session", to: "payments#get_stripe_id"
  get "/payments/success", to: "payments#success"
  post "/payments/webhooks", to: "payments#webhooks"
end
