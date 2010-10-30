Capsulecontacts::Application.routes.draw do
  resources :searches, only: [:new, :create]
  match '/search' => 'searches#create'
  root to: 'searches#new'
end
