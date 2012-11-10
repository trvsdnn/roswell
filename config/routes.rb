Roswell::Application.routes.draw do
  get 'signup', :to => 'users#new', :as => 'signup'
  get 'login', :to => 'sessions#new', :as => 'login'
  get 'logout', :to => 'sessions#destroy', :as => 'logout'

  get 'search', :to => 'search#index'

  resources :sessions
  resources :users

  namespace :accounts do
    resources :generic_accounts, :path => 'generic'
    get 'generic/group/:group', :to => 'generic_accounts#grouped', :as => 'grouped_generic'
    resources :web_accounts, :path => 'web'
    get 'web/group/:group', :to => 'web_accounts#grouped', :as => 'grouped_web'
  end

  resources :software_licenses
  get 'software_licenses/group/:group', :to => 'software_licenses#grouped', :as => 'grouped_software_licenses'
  resources :notes
  get 'notes/group/:group', :to => 'notes#grouped', :as => 'grouped_notes'

  namespace :admin do
    resources :users, :except => [ :show ]
    resources :groups, :except => [ :show ]
  end

  root :to => 'accounts/web_accounts#index'
end
