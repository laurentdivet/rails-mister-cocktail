Rails.application.routes.draw do
  resources :cocktails, only: [:show, :index, :new, :create] do
    resources :doses, only: [:create]
  end
  resources :doses, only: [:destroy]
  root "cocktails#index"
end
