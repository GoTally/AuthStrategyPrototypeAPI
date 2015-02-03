Rails.application.routes.draw do
  # Uptime check
  get '/status', to: 'health#status', defaults: {format: 'text'}
end
