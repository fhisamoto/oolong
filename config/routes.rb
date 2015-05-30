Rails.application.routes.draw do
  resources :drivers, except: [:new, :edit] do
    member do
      post 'status', :action => 'update'
      get 'status', :action => 'show'
    end
  end
end
