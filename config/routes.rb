Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  # root to: 'admin/dashboard#index'
  # root "homes#index"
  
  resources :roles
  namespace :api, defaults: { format: :json } do
    # root 'articles#index'
    resources :roles, only: %i[index show new edit create update, destroy] # TODO: only index, show
    resources :users, only: %i[index show update, destroy] do # TODO: remove index
      collection do
        get 'search' #, to: 'users#search'
      end
    end
    get 'profile', to: 'users#profile'
    put '/edit-profile', to: 'users#edit'
  end

  # get "up" => "rails/health#show", as: :rails_health_check
end
