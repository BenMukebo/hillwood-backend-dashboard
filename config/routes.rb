Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  root to: 'admin/dashboard#index'
  resources :roles

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api, defaults: { format: :json } do
    root 'users#index'
    # mount_devise_token_auth_for 'User', at: 'auth', base_controller: 'Api::ApiController' # This didn't work
    mount_devise_token_auth_for 'User', at: 'auth', base_controller: 'Api::ApiController', controllers: {
      confirmations:      'devise_token_auth/confirmations',
      passwords:          'devise_token_auth/passwords',
      omniauth_callbacks: 'devise_token_auth/omniauth_callbacks',
      registrations:      'devise_token_auth/registrations',
      sessions:           'devise_token_auth/sessions',
      token_validations:  'devise_token_auth/token_validations'
    }
    resources :roles, only: %i[index show new edit create update destroy] # TODO: only index, show
    resources :users, only: %i[index show update destroy] do
      collection do
        get 'search' #, to: 'users#search'
      end
    end
    get 'full-profile', to: 'users#profile'
    put '/edit-profile', to: 'users#edit'
    resources :videos, only: %i[index show create update, destroy]
    resources :movie_writters, only: %i[index show create update destroy]
    resources :movie_outcasts, only: %i[index show create update destroy]
    resources :movies, only: %i[index show create update destroy]
    resources :movie_likes, only: %i[index create update destroy]
    resources :movie_comments, only: %i[index show create update destroy]
    
    resources :series, only: %i[index show create update destroy]
    resources :seasons, only: %i[index show create update destroy]
    resources :episodes, only: %i[index show create update destroy]
    resources :serie_likes, only: %i[index show create update destroy]
    resources :serie_comments, only: %i[index create update destroy]

    scope '/options' do
      # resources :movie_genres, only: %i[index], path: 'movie-genres', as: 'movie_genres'
      # resources :movie_genres, path: 'movie-genres', only: %i[index]
      get 'movie-genres', to: 'movie_genres#options'
      get 'movie-writters', to: 'movie_writters#options'
      get 'movie-outcasts', to: 'movie_outcasts#options'
      get 'movies', to: 'movies#options'
      get 'series', to: 'series#options'
      get 'seasons', to: 'seasons#options'
      get 'episodes', to: 'episodes#options'
    end

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
