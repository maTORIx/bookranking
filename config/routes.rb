Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :auth, except:[:index, :update, :edit, :show] do
  end

  resources :users, except:[:index] do
    resources :book_shelf, except: [:show, :edit, :update, :new]
  end

  resources :books, except: [:index]  do
    resources :reviews, except: [:show]
    resources :stars, only: [:create]
    resources :tags, only:[:create]
    resources :authors, only:[:create]
  end

  resources :rankings, only: [:index] do
    collection do
      resources :tags, only: [:show, :index]
      resources :authors, only: [:show, :index]
      resources :stars, only: [:index]
    end
  end
end
