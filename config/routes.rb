Rails.application.routes.draw do
  scope module: :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :tokens, only: [:create]
      resources :events, only: [:index]
    end
  end

  # Uptime check
  get '/status', to: 'health#status', defaults: {format: 'text'}
end
