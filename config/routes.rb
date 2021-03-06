Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  get "/signin", to: "auth#new"
  get "/login" => redirect("/signin")
  get "/signup", to: "users#new"

  resources :auth, except:[:index, :update, :edit, :show] do
    post "/confirm", to: "users#confirm_email", on: :collection
  end

  resources :users, except:[:index] do
    resources :book_shelf, only: [:show, :create, :destroy], param: :book_id
    get "/confirm/:confirm_hash", to: "users#confirm"
  end

  resources :reviews, only: [:show, :edit, :update] do
    post "/favorite", action: "favorite"
  end

  resources :books, except: [:index]  do
    resources :reviews, only: [:index, :create, :new]
    resources :easy_reviews, only: [:create]
    resources :tags, only:[:create, :update], param: :name
    resources :authors, only:[:create, :destroy], param: :name
  end

  resources :rankings, only: [:index] do
    collection do
      resources :tags, only: [:index]
      resources :authors, only: [:index]
      resources :categories, only: [:index]
    end
  end

  resources :requests, only: [:index, :show, :update, :destroy]
end
