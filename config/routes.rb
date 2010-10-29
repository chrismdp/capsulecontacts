Capsulecontacts::Application.routes.draw do
  resource :search, :only => [:create, :new]
  root to: 'searches#new'
end
