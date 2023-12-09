Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # root to: 'admin/dashboard#index'
  # root "homes#index"
  resources :roles

  mount_devise_token_auth_for 'User', at: 'auth'
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
  # get '/docs' => redirect('/swagger/dist/index.html?url=/apidocs/api-docs.json')
end
