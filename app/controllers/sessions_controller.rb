class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      a_notice = "Welcome back, #{user.firstname}!"
      if user.admin
        a_notice += "  (You are an ADMIN)"
      end
      redirect_to movies_path, notice: a_notice
    else
      flash.now[:alert] = "Log in failed..."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to movies_path, notice: "C-Ya later"
  end
end
