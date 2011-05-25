class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def me
    redirect_to user_path(current_user._id)
  end

end
