class Admin::UsersController < UsersController

  def show
    puts "show me!"
    puts params
    puts "show me!"
    if params.has_key? :delete
      puts "**********delete me"
    end
    @users = User.all.page(params[:page]).per(10)
  end

  def destroy
    puts "**********delete me"
    puts params
    puts "**********delete me"
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_user_path
  end


end
