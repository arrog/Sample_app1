SampleApp::Application.routes.draw do

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
                     controllers: {omniauth_callbacks: "omniauth_callbacks"}
                     
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  
  resources :users do
      member do
        get :following, :followers
        get :follow
        get :unfollow
        get :team
        get :defier
      end
  end  
  
  resources :admins
  
  resources :groups do
    resources :users do
      member do
        get :invite_group
      end
    end
    member do
      get :rejoindre
      get :rajouter
    end
  end
  
  resources :invitations do
    member do
      match 'accept'
      match 'reject'
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
        get :follow
        get :unfollow
      end
  end
      
  resources :arguments do
    resources :argcoms
    member { post :like }
  end
  
  resources :argcoms
  resources :comments
    
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
  match '/experts',    to: 'static_pages#list_doulins'
  match '/dialectiques',    to: 'static_pages#list_challenges'
  match '/debats',    to: 'static_pages#list_debates'
  
  get 'tags/:tag', to: 'static_pages#list', as: :tag
  
  match "/search_results/" => "static_pages#search_results", :via => :get, :as =>"search_results"
  
  
end
