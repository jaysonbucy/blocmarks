class BookmarksController < ApplicationController

  before_action :authenticate_user!

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new(:topic => @topic)
    #redirect_back(fallback_location: root_path)
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.new(bookmark_params)

     if @bookmark.save
       flash[:notice] = "Bookmark was saved."
       redirect_to [@topic]
     else
       flash.now[:alert] = "There was an error saving the bookmark. Please try again."
       render :new
     end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.find(:id)
    binding.pry
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.update(bookmark_params)
      flash[:notice] = "Bookmark was updated."
      redirect_to [@topic]
    else
      flash.now[:alert] = "There was an error saving the bookmark1. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.destroy
      flash[:notice] = "\"#{@bookmark.url}\" was deleted successfully."
      redirect_to [@topic]
    else
      flash.now[:alert] = "There was an error deleting the bookmark."
      render :show
    end
  end

  private
  def bookmark_params
    params.require(:bookmark).permit(:url)
  end

end
