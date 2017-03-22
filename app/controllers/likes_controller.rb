class LikesController < ApplicationController

  before_action :authenticate_user!

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    @topic = @bookmark.topic
    like = current_user.likes.build(bookmark: @bookmark)

    if like.save
      redirect_to @topic
    else
      redirect_to @topic
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    @topic = @bookmark.topic
    like = current_user.likes.find(params[:id])

    if like.destroy
      redirect_to @topic
    else
      redirect_to @topic
    end
  end

end
