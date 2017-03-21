class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @email = params[:sender]
    @user = User.find_by(email: @email)
    @topic = Topic.find_by(title: params[:subject])
    @url = params["body-plain"]

    if @user.nil?
      @user = User.new(email: @email, password: 'password')
    end

    if @topic.nil?
      @topic = @user.topics.create(title: params[:subject])
    end

    @bookmark = @topic.bookmarks.create(url: @url)

    head 200
  end
  
end
