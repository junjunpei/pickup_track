Rails.application.routes.draw do
  root 'static_pages#top'

  get '*path', to: 'static_pages#top'

  namespace :api do
    resources :users do
      collection do
        get 'me'
      end
    end
    post '/validate/email', to: 'users#registered?'
    resources :sessions
    resources :tracks, only: %i[create destroy]
    post 'tracks/search', to: 'tracks#search'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # resources :users do
  #   get 'delete', to: 'users#delete'
  # end
  #
  # get    'login',  to: 'user_sessions#new'
  # post   'login',  to: 'user_sessions#create'
  # delete 'logout', to: 'user_sessions#destroy'
  #
  # get 'tracks/search', to: 'tracks#index'
end
