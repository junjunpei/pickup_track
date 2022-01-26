Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root 'static_pages#top'

  namespace :api do
    resources :users do
      collection do
        get 'me'
      end
    end
    post '/validate/email', to: 'users#registered?'
    resources :sessions
    resources :tracks do
      collection do
        post 'search', to: 'tracks#search'
      end
    end
    resources :password_resets, only: %i[create update]
    resources :contacts, only: :create
    resources :histories, only: %i[index create destroy] do
      collection do
        get 'times', to: 'histories#times'
      end
    end
  end

  get '*path', to: 'static_pages#top'
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
