Rails.application.routes.draw do
  # api
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show]
      resources :registration, only: %i[index create edit update destroy]
      post '/authenticate_mail', to: 'registration#authenticate_mail'
      post '/sign_in', to: 'registration#sign_in'
      get '/dash', to: 'top#index'
      resources :search, only: %i[index]
      resources :change_mail, only: %i[index create]
      get '/change_mail/confirmation', to: 'change_mail#confirmation'
      put '/change_password/confirmation', to: 'change_password#confirmation'
    end
  end
end
