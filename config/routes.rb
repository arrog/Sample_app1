SampleApp::Application.routes.draw do

  devise_for :users

  resources :users do
      member do
        get :following, :followers
      end
  end  
  
  resources :admins
  
  resources :invitations do
    member do
      match 'accept'
      match 'reject'
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
    resources :performances 
    resources :judgments
     member do
        match 'vote'
        match 'starting'
        match 'finish'
        match 'grade'
        match 'join_one'
        match 'join_two'
        match 'join_three'
        match 'join_four'
        match 'join_five'
        match 'join_six'
        match 'join_seven'
        match 'join_eight'
        match 'join_judge'
      end
  end
      
  resources :arguments do
    resources :argcoms
    member { post :like }
  end
  
  resources :argcoms
    
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
  
  match '/list',    to: 'static_pages#list'  
  get 'tags/:tag', to: 'static_pages#list', as: :tag
  match "/search_results/" => "static_pages#search_results", :via => :get, :as =>"search_results"

  
end
