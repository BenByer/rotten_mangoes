class Admin::UsersController < ApplicationController
  def show
    @users = User.all
  end
end
