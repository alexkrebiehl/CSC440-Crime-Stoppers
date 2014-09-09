CrimeStoppers::Application.routes.draw do
  resources :users 
  resources :sessions 
  
  get "sign_out", to: "sessions#destroy"
  root to: "users#index"  
end
