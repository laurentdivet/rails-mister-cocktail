Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'cocktails#index'
  resources :cocktails do
    resources :doses, only: [:new, :create]
    collection do
      get '/search', to: 'cocktails#index'
    end
  end
  # delete 'doses/:id' => 'doses#destroy'
  resources :doses, only: [:destroy]
  resources :ingredients, only: [:index] do
    get :autocomplete_ingredient_name, :on => :collection
  end

  mount Attachinary::Engine => "/attachinary"
end


# resources :ingredients do
#   get :autocomplete_ingredient_name, :on => :collection
# end
