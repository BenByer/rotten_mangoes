class Admin::UsersController < UsersController
  def index

  end

  def new
    @user = User.new
    puts "&&Admin::UsersController new(@users):   #{@users}"
  end

  def create
    @user = User.new(user_params)
    user_exists = User.exists?(:email => @user.email)
    if !user_exists && @user.save
      puts "&&Admin::UsersController Created new user #{@user.firstname}"
      redirect_to admin_user_path(@user), notice: "Created new user #{@user.firstname}!"
    else
      puts "&&Admin::UsersController User email already in the database #{@user.email}!"
      render :new

   #   redirect_to admin_user_path(@user), notice: "User email already in the database #{@user.email}!"
    end
  end

  def show
    puts "show me!"
    puts params
    puts "show me!"
    if params.has_key? :id
      if params[:id] == 'edit'
        puts "**#{params[:id]} in the show"
      end
    end
    if params.has_key? :delete
      puts "**delete me in the show"
    end
    @users = User.all.page(params[:page]).per(10)
  end

  def edit
    puts "***Hey, it's in EDIT"
    puts params
    @user = User.find(params[:id])
    puts @user.id
#    redirect_to admin_user_path
  end

  def update
    @user = User.find(params[:id])
    puts @user
    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    puts "**********delete me"
    puts params[:id]
    puts session[:user_id]
    puts "**** admin_user_path(user)"
    @user = User.find(params[:id])
    if session[:user_id] != @user.id
      mail = UserMailer.deleted_email(@user)
      mail.deliver
      @user.destroy
    end
    redirect_to admin_user_path
  end

  def impersonate
    @user = User.find(params[:id])
    session[:actual_user_id] = session[:user_id]
    session[:user_id] = @user.id
    redirect_to [:admin, :users], notice: "Switched to other"
  #  raise session[:user_id].inspect
  end

  def ensure_admin_only
    redirect_to :root unless admin?
  end

  # def admin?
  #   #current_user && current_user.is_admin?
  #   current_user.try :admin? || impersonating?
  # end

  # def impersonating?
  #   actual_user.try(:admin)?
  # end

  # def actual_user
  #   User.find(session[:actual_user_id]) if session[:actual_user].present?
  # end

  #helper_method :admin?, :actual_user, :impersonating?

end
