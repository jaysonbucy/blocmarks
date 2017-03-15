class WelcomeController < ApplicationController
  before_action :authenticate_user!

  def show
  end
end
