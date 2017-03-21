class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @email = params[:sender]
    @user = User.find_by(email: @email)
    @topic = Topic.find_by(params[:subject])
    @url = params["body-plain"]

    if @user?
      @user = User.new(email: @email, password: 'password')
      @user.skip_confirmation!
      @user.save!
    end

    if @topic?
      @topic = @user.topics.create(title: params[:subject])
    end

    @bookmark = @topic.bookmarks.create(url: @url, user_id: @user_id)

    head 200
  end
end
