Rails.application.routes.draw do
  devise_for :users

  resources 'topics' do
    resources 'bookmarks', except: [:index, :show]
  end

  root 'topics#index'
end
