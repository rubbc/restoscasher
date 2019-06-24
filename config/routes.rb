Rails.application.routes.draw do
  devise_for :users
  resources :restaurants do
    resources :items, only: [ :new, :create, :destroy, :show, :index ]
  end

  get '/tagged', to: "restaurants#tagged", as: :tagged

  root to: "restaurants#index"
end
