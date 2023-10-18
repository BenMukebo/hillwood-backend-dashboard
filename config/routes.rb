Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # get "up" => "rails/health#show", as: :rails_health_check

  # root "articles#index"
  resources :roles, only: %i[index show new edit create update]
end
