CrimeStoppers::Application.routes.draw do
  resources :users 
  resources :sessions 
  resources :crime_records do
    collection { post :import }
  end
  get "sign_out", to: "sessions#destroy"
  get "forget_password_form", to: "users#forget_password_form"
  post "forget_password", to: "users#forgot_password"
  root to: "users#index"
end
