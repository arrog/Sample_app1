SampleApp::Application.routes.draw do

  devise_for :users

  resources :users do
      member do
        get :following, :followers
      end
  end  
  
  resources :debates, shallow: true do 
    resources :arguments
    member { post :vote }
  end
  
  resources :doulins, shallow: true do 
    resources :arguments
    member { post :vote_expert }
  end
  
  resources :challenges, shallow: true do 
    resources :arguments
    member { post :vote }
  end
  
  resources :arguments do
    resources :argcoms
    member { post :like }
  end
  
  resources :argcoms
  
    
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  
  
  root to: 'static_pages#home'

  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/apprendre', to: 'static_pages#apprendre_a_debattre'
  match '/cgu',    to: 'static_pages#cgu'
  match '/faq',    to: 'static_pages#faq'
  match '/presse',    to: 'static_pages#presse'
  
  
  #match '/signup',  to: 'users#new'
  #match '/signin',  to: 'sessions#new'
  #match '/signout', to: 'sessions#destroy', via: :delete
  match '/create', to: 'debates #new'  ## to be deleted
  
  
end
