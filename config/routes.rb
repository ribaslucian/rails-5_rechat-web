# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root to: 'guest/users#login'
  mount ActionCable.server => '/cable'
  
  
  namespace :guest do
    get '/', to: 'users#login'
    get '/guest', to: 'users#login'

    match 'users/sign_in', to: 'users#sign_in', via: [:get, :post], as: :sign_in
    match 'users/login', to: 'users#login', via: [:get, :post]
  end
  
  
  namespace :researcher do
    get '/', to: 'dashboard#index'
    get '/researcher', to: 'users#login'
    get '/chats/:user_id', to: 'chats#private'
    get 'dashboard/index', to: 'dashboard#index'
    
    get 'users/logout', to: 'users#logout', as: :logout
    
    resources :interactions
    get '/interactions/start/:id', to: 'interactions#start'
    
    resources :users
    
    resources :messages
    
    get '/reports/users', to: 'reports#users'
    get '/reports/bots', to: 'reports#bots'
    get '/reports/messages', to: 'reports#messages'
  end
  
  namespace :voluntary do
    get '/', to: 'contacts#index'
    get '/voluntary', to: 'contacts#index'
    get 'users/logout', to: 'users#logout', as: :logout
    
    get '/voluntary/chat/private/:contact_id', to: 'chats#private', as: :chat_private
  end
  
  namespace :api, defaults: { format: :json } do
    post 'authorize' => 'authorizers#authorize'
  end
end

