Rails.application.routes.draw do
  root "static_pages#home"
  get  "/signup",  to: "users#new"
  post "/signup",  to: "users#create"
  get    "/login",   to: "sessions#new"
  get    "/user_edit",  to: "users#edit"
  patch    "/user_update",  to: "user#update"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :users
end
