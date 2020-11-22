require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  mount Sidekiq::Web => '/sidekiq'
  root 'reminders#index'

  devise_scope :user do
    root 'devise/sessions#new', as: :unauthenticated_root
  end

  resources :reminders, except: [:create, :new, :destroy]
  resources :short_messages, except: [:create, :new, :destroy]
  resources :short_message_templates, except: [:create, :new, :destroy]
end
