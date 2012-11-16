class Admin::GroupsController < ApplicationController
  before_filter :authorize_admin

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
    @users = User.all
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to admin_groups_path, :notice => 'Group created'
    else
      @users = User.all
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
    @users = User.all
  end

  def update
    @group = Group.find(params[:id])

    if @group.update_attributes(group_params)
      redirect_to admin_groups_path, :notice => 'Group updated'
    else
      @users = User.all
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(
      :name,
      :user_ids
    )
  end
end
