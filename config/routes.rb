SampleApp::Application.routes.draw do
  
  constraints(:host => /^www\./) do
    match "(*x)" => redirect { |params, request|
      URI.parse(request.url).tap {|url| url.host.sub!('www.', '') }.to_s
    }
  end
  
  resources :articles


  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
                     controllers: {omniauth_callbacks: "omniauth_callbacks"}
                     
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  
  resources :notes
  
  resources :users do
      member do
        get :following, :followers
        get :follow
        get :unfollow
        get :team
        get :defier
        get :notifications
        get :activities
        get :active
        get :my_groups
        get :sesdefis
        get :sesvotes
        get :sesdebatsouverts
      end
  end  
  
  resources :admins
  resources :flags
  
  resources :groups do
    resources :users do      
      member do
        get :invite_group
      end
    end
    member do
      get :rejoindre
      get :rajouter
      get :members
    end
  end
  
    resources :events do
      member do
        get :rejoindre
        match 'publish'
        match 'vote'
      end
    end
  
  resources :invitations do
    member do
      match 'accept'
      match 'reject'
    end
  end
  
  resources :relationships do
    member do
      match :accepter
      match :rejeter
    end
  end
  
  resources :memberships do
    member do
      match 'accept'
      match 'reject'
    end
  end
  
  
  resources :debates, shallow: true do 
    resources :arguments
    member do 
      match 'vote'
      match 'publish'
      match 'promote1'
      match 'promote2'
      match 'promote3'
      match 'promote4'
      match 'promote5'   
      match 'partenariat'               
      get :follow
      get :unfollow
      
    end
  end

  resources :expertises
  resources :judgments
  resources :repliques
      
  resources :doulins, shallow: true do 
    resources :arguments
    resources :expertises
    resources :comments
    resources :repliques
    member do
       match 'vote_expert'
       match 'promote'        
       match 'publish'
       match 'ready'
       match 'start'
       match 'finish'
       match 'next'
       get :follow
       get :unfollow      
    end
  end
   
  resources :challenges, shallow: true do 
    resources :arguments
    resources :comments
    resources :performances 
    resources :judgments
    resources :repliques
     member do
        match 'vote_challenge'
        match 'vote'
        match 'starting'
        match 'next'
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
        match 'join_judge_two'
        match 'join_judge_three'
        match 'promote'
        get :follow
        get :unfollow
      end
  end
      
  resources :arguments do
    resources :argcoms
    member { post :like }
  end
  
  resources :argcoms
  
  resources :comments do
    member do
      match 'like_comment'
    end
  end
    
  resources :microposts, only: [:create, :destroy]
  
  root to: 'static_pages#home'
  
  match '/presentation',    to: 'static_pages#presentation'
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/abonnements', to: 'static_pages#apprendre_a_debattre'
  match '/cgu',    to: 'static_pages#cgu'
  match '/faq',    to: 'static_pages#faq'
  match '/presse',    to: 'static_pages#presse'
  match '/login',    to: 'static_pages#login'
  match '/list',    to: 'static_pages#list'
  match '/experts',    to: 'static_pages#list_doulins'
  match '/dialectiques',    to: 'static_pages#list_challenges'
  match '/incomplets', to:'static_pages#list_ajoindre'
  match '/debats',    to: 'static_pages#list_debates'
  match '/challenge',    to: 'static_pages#challenge'
  
  get "errors/error_404"
  get "errors/error_500"  
  
  get 'tags/:tag', to: 'static_pages#list', as: :tag
  
  match "/search_results/" => "static_pages#search_results", :via => :get, :as =>"search_results"
  
  
end
