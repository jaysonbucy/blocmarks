Rails.application.routes.draw do
  devise_for :users

  resources 'topics' do
    resources 'bookmarks', except: [:index, :show] do
      resources 'likes', only: [:index, :create, :destroy]
    end
  end

  post :incoming, to: 'incoming#create'

  root 'topics#index'
end
