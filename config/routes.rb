Rails.application.routes.draw do
  resources :post_saves
  resources :post_views
  resources :follows
  resources :posts do
    resource :post_likes, only: [:create, :destroy]
    resource :post_comments, only: [:create, :destroy]
  end
  resources :club_team_trainings
  resources :club_training_centers
  resources :coach_teams
  resources :player_teams
  resources :club_teams
  resources :club_sports
  resources :admin_profiles
  resources :board_profiles
  resources :coach_profiles do
    member do
      patch :remove_from_club
    end
  end

  resources :player_profiles do
    member do
      patch :remove_from_club
    end
  end

  resources :club_pitches do
    member do
      patch :remove_from_ct
      patch :add_to_ct
    end
  end

  resources :club_locker_rooms do
    member do
      patch :remove_from_ct
      patch :add_to_ct
    end
  end

  resources :club_profiles
  resources :user_profiles
  resources :sports


  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"

    
  }

  devise_scope :user do
    # SIGN UP
    get "/user_profile/sign_up", to: "users/registrations#new", as: :new_user_profile_registration, defaults: { role: "User" }
    post "/user_profile", to: "users/registrations#create"

    get "/player_profile/sign_up", to: "users/registrations#new", as: :new_player_profile_registration, defaults: { role: "Player" }
    post "/player_profile", to: "users/registrations#create"

    get "/club_profile/sign_up", to: "users/registrations#new", as: :new_club_profile_registration, defaults: { role: "Club" }
    post "/club_profile", to: "users/registrations#create"

    get "/coach_profile/sign_up", to: "users/registrations#new", as: :new_coach_profile_registration, defaults: { role: "Coach" }
    post "/coach_profile", to: "users/registrations#create"

    get "/board_profile/sign_up", to: "users/registrations#new", as: :new_board_profile_registration, defaults: { role: "Board" }
    post "/board_profile", to: "users/registrations#create"

    get "player_profile/sign_up/equipas", to: "users/registrations#equipas"
  end

  # Dashboard

  get "dashboard/club_dashboard", as: :club_dashboard
  get "dashboard/club_teams", as: :club_teams_dashboard
  get "dashboard/club_board", as: :club_board_dashboard
  get "dashboard/club_equipment", as: :club_equipment_dashboard
  get "dashboard/club_infrastructures", as: :club_infrastructures_dashboard
  

  post "dashboard/create_sport", to: "dashboard#create_sport", as: :create_club_sport

  get "account_type/index", as: :choose_account_type

  get "home/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  root to: "home#index"
end
