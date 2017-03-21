class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @email = params[:sender]
    @user = User.find_by(email: @email)
    @topic = Topic.find_by(title: params[:subject])
    @url = params["body-plain"]

    if @user.nil?
      @username = get_user_id(@email)
      @user = User.new(email: @email, username: @username, password: 'password')
      @user.save!
    end

    if @topic.nil?
      @topic = @user.topics.create(title: params[:subject])
    end

    @bookmark = @topic.bookmarks.create(url: @url)

    head 200
  end
  private
  def get_user_id(email)
    email.split("@")[0]
  end

end
