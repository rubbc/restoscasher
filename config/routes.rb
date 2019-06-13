Rails.application.routes.draw do
  devise_for :users
  resources :restaurants do
    resources :items, only: [ :new, :create ]
  end

  get '/tagged', to: "restaurants#tagged", as: :tagged

  root to: "restaurants#index"
end
