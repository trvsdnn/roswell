class Admin::UsersController < AdminController

  def index
    @users = User.where(:admin => false).all
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
      render :edit
    end
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
