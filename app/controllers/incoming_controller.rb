class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @user = User.find_by(email: params[:sender])
    @params = Topic.find_by(params[:subject])
    @url = params["body-plain"]

    if @user == nil
      @user = User.new
      @user.email = params[:sender]
      @user.password = 'password'
      @user.save!
    end

    if @topic == nil
      @topic = Topic.new
      @topic.user_id = @user.id
      @topic.title = params[:subject]
      @topic.save!
    end

    @bookmark = Bookmark.new
    @bookmark.topic_id = @topic.id
    @bookmark.url = @url.strip
    @bookmark.save!

    head 200
  end
end
