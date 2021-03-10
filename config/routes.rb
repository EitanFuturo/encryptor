Rails.application.routes.draw do
  root 'messages#index'
  resources :messages
  post 'messages/decrypt_message', to: 'messages#decrypt_message', as: :decrypt_message
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
