class Admin::UsersController < AdminController
  before_filter :authorize_admin

  def index
    @users = User.where
  end

  def new
    @user = User.new
    @groups = Group.all
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, :notice => 'User created'
    else
      @groups = Group.all
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @groups = Group.all
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_users_path, :notice => 'User updated'
    else
      @groups = Group.all
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, :notice => "User `#{@user.username}' removed"
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :password,
      :password_confirmation,
      :group_ids
    )
  end

end
