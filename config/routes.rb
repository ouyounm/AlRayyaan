AlRayyaan::Application.routes.draw do
  get "calendar/show"
  devise_for :users
  authenticated :user do
  root "calendar#show", as: "authenticated_root"
  end

  unauthenticated do
    devise_scope :user do
      root "sessions#new", :as => "unauthenticated"
    end
  end
end
