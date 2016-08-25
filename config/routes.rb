Rails.application.routes.draw do
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
