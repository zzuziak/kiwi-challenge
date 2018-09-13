Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :occurences, only: [:index, :new] do
    get 'overview', on: :collection
  end

end
