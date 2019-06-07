Rails.application.routes.draw do
  resources :restaurants do
    resources :items, only: [ :new, :create ]
  end

  root to: "restaurants#index"
end
