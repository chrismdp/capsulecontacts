Capsulecontacts::Application.routes.draw do
  match "/search", to: 'search#search'
  root to: 'search#new'
end
