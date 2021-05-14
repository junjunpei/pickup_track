Rails.application.routes.draw do
  root 'static_pages#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  get    'login',  to: 'user_session#new',     as: :login
  post   'login',  to: 'user_session#create'
  delete 'logout', to: 'user_session#destroy', as: :logout
end
