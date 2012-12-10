class UsersController < ApplicationController
  before_filter :authorize
  before_filter :authorize_me

  def edit
  end

  def update
    if @user.update_attributes params[:user]
      redirect_to edit_user_path(@user), :notice => "account updated"
    else
      render action: :edit
    end
  end

  private
  def authorize_me
    @user = User.find(params[:id])
    deny_access! if current_user.id != @user.id
  end
end
