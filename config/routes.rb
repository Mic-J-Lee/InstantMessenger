Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :chat_rooms, only: [:new, :create, :show, :index]
  root 'home#index', via: :get
  mount ActionCable.server => '/cable'
  get '/unread', to: 'messages#unread', as: 'unread_messages'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
