Rails.application.routes.draw do
  resources :drivers, except: [:new, :edit] do
    member do
      post 'status', :action => 'update'
      get 'status', :action => 'show'
    end

    collection do
      get 'inArea', :action => 'in_area'
    end
  end
end
