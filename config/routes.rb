Rails.application.routes.draw do
  root 'garden#index'
  get '/*app', to: 'garden#index'
end
