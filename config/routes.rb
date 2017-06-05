Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :chat_rooms, only: [:new, :create, :show, :index]
  root 'chat_rooms#index', via: :get
  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
