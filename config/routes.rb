Rails.application.routes.draw do
  resources :drivers, except: [:new, :edit] do
    member do
      post 'status'
    end
  end
end
