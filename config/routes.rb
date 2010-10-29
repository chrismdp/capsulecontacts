Capsulecontacts::Application.routes.draw do
  match "/search", to: 'searches#search'
  root to: 'searches#new'
end
