Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    mount Hyperloop::Engine => '/hyperloop'
  end
  # mount Hyperloop::Engine => '/hyperloop'
  root 'hyperloop#tickettracker'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
