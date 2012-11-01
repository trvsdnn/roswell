Roswell::Application.routes.draw do
  get 'signup', :to => 'users#new', :as => 'signup'
  get 'login', :to => 'sessions#new', :as => 'login'
  get 'logout', :to => 'sessions#destroy', :as => 'logout'

  resources :sessions
  resources :users

  namespace :accounts do
    resources :generic
    get 'generic/tag/:tag', :to => 'generic#tagged', :as => 'tagged_generic'
  end

  resources :software_licenses
  get 'software_licenses/tag/:tag', :to => 'software_licenses#tagged', :as => 'tagged_software_licenses'
  resources :notes
  get 'notes/tag/:tag', :to => 'notes#tagged', :as => 'tagged_notes'

  namespace :admin do
    resources :users
  end

  root :to => 'notes#index'
end
