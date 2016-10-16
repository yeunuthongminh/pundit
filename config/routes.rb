Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: "devises/sessions"}
  get "/pages/*page" => "pages#show"
  root "pages#show", page: "home"

  namespace :admin do
    resources :roles
  end
end
