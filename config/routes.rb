Rails.application.routes.draw do
  get 'organizer/new'
  post 'organizer/create'
  delete 'organizer/:id/' => 'organizer#destroy' 

  resources :check_in
  post 'check_in/submit'

  get 'sponsors/new'
  #post 'charges/create'
  post 'sponsors/create'

  get 'sponsorships/new'
  post 'sponsorships/create'

  #for searching for golf courses
  get 'tournaments/update_courses' => 'tournaments#update_courses'
  get 'tournaments/update_hosts' => 'tournaments#update_hosts'
  get 'tournaments/:id/refund' => 'tournaments#refund'
  get 'tournaments/:id/resend_confirmation' => 'tournaments#resend_confirmation'
  post 'tournaments/:id/email' => 'tournaments#email'
  get 'tournaments/:id/delete_logo' => 'tournaments#delete_logo'



  get 'scheduled_events/new'
  post 'scheduled_events/create'
  get 'unscheduled_events/new'
  post 'unscheduled_events/create'
  get 'photos/new'
  post 'photos/create'
  resources :tournaments do
   resources :scheduled_events, only: :destroy
   resources :unscheduled_events, only: :destroy
   resources :photos, only: :destroy
  end


  devise_for :people


  get '/players/:id' => 'players#show'#, constraints: { id: /^[1-9][0-9]*$/ }

  get 'players/new'
  post 'players/create'

  get 'teams/:id' => 'teams#show'

  #ME FIX
  get 'people/:id' => 'people#show'#, constraints: { id: /^[1-9][0-9]*$/ }
  get 'people' => 'people#index'


  get 'welcome/index'

  #Rabachi: for the static pages
  get "/misc_pages/:misc_page" => "misc_pages#show"

  get 'tournaments/:id/organize' => "tournaments#organize"
  
  #for private tournaments
  controller :tournaments do
    get 'tournaments/:id/private/:key'     => :private_url
  end

  resources :golf_courses
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Mailer Stuff
  get 'contact', to: 'messages#new', as: 'contact'
  post 'contact', to: 'messages#create'
  post '/tournaments/invite' => "tournaments#invite"

  #payments
  resources :charges
  #ZS: added sponsorship resources to create the default routes
#  resources :sponsorships


  # saves a golf course after model validation
  # post '/create_golf_course', to: 'golf_courses#create_golf_course'

  #Last Chance, all errors
  get "*any", via: :all, to: "errors#not_found"

end
