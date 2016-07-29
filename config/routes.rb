Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :comics, only: [:toggle] do
    put :toggle_favourite, on: :member
  end
  root to: "comics#index"
end
