class PostsController < ApplicationController
  before_action :check_login
  def index
  end

  private

  def check_login
    if !current_user
      redirect_to new_user_registration_path
    end
  end
end
