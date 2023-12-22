Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  root to: 'admin/dashboard#index'
  resources :roles
  
  namespace :api, defaults: { format: :json } do
    root 'users#index'
    mount_devise_token_auth_for 'User', at: 'auth', base_controller: 'Api::ApiController' # This didn't work
    resources :roles, only: %i[index show new edit create update, destroy] # TODO: only index, show
    resources :users, only: %i[index show update, destroy] do # TODO: remove index
      collection do
        get 'search' #, to: 'users#search'
      end
    end
    get 'profile', to: 'users#profile'
    put '/edit-profile', to: 'users#edit'
    resources :videos, only: %i[index show create update, destroy]
    # get '/docs' => redirect('/swagger/dist/index.html?url=/apidocs/api-docs.json')
  end

  # concern :api_endpoints do
  #   mount_devise_token_auth_for 'User', at: 'api/auth', skip: [:omniauth_callbacks], :defaults => {:format => :json} do
  # end

  # namespace :api, defaults: { format: :json } do
  #   concerns :api_endpoints
  #   resources :roles, only: %i[index show new edit create update, destroy]
  # end
end
