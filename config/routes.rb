Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }, except: %i(new edit) do
    namespace :v1 do
      resources :plants, only: [:show]
      resources :photos, only: [:create]
    end
  end

  match 'auth/:provider',
    constraints: { provider: 'google' },
    to: 'sessions#passthru',
    as: :omniauth_authorize,
    via: [:get, :post]

  get 'auth/:provider/callback', to: 'sessions#create', constraints: { provider: 'google' }
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  root 'garden#index'
  get '/*app', to: 'garden#index'
end
