class Admin::UsersController < ApplicationController
  def show
    @users = User.all.page(params[:page]).per(5)
  end
end
