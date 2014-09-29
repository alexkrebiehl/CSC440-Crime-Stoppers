CrimeStoppers::Application.routes.draw do
  resources :users 
  resources :sessions 
  resources :crime_records do
    collection { post :import }
  end
  get "sign_out", to: "sessions#destroy"
  root to: "users#index"  
end
