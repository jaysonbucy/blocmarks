class UsersController < ApplicationController
  def show
    @user_bookmarks = User.find(params[:id]).bookmarks
    @user_likes = User.find(params[:id]).likes
  end
end
