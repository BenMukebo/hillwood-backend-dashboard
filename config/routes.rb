Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount_devise_token_auth_for 'User', at: 'auth'

  # root to: 'admin/dashboard#index'
  root "homes#index"
  
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

# https://devise-token-auth.gitbook.io/devise-token-auth/usage/multiple_models
# https://github.com/lynndylanhurley/devise_token_auth/blob/master/docs/usage/multiple_models.md
# https://stackoverflow.com/questions/73572579/devise-token-auth-customised-routes-for-additonal-endpoints

# Email Template Overrides
# https://devise-token-auth.gitbook.io/devise-token-auth/usage/overrides

# Create an api  namespace and move the rote inside and create an user API