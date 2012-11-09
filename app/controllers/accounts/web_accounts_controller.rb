class Accounts::WebAccountsController < ApplicationController
  before_filter :authorize
  before_filter :set_groups, :except => [ :create, :update, :show ]

  def index
    if current_user.admin
      @accounts = WebAccount.all
    else
      @accounts = WebAccount.any_of({ :group_ids.in => current_user.group_ids }, { :group_ids => [] })
    end
  end

  def grouped
    @group = Group.where(:name => params[:group]).first
    not_found unless @group
    @notes = WebAccount.where(:group_ids.in => [@group.id])
    render :template => 'accounts/web_accounts/index'
  end


  def new
    @account = WebAccount.new
    @allowed_groups = allowed_groups
  end

  def create
    @account = WebAccount.new(account_params)

    if @account.save
      redirect_to [ :accounts, @account ], :notice => 'Account created'
    else
      render :new
    end
  end

  def show
    @account = WebAccount.find(params[:id])
  end

  def edit
    @account = WebAccount.find(params[:id])
    @allowed_groups = allowed_groups
  end

  def update
    @account = WebAccount.find(params[:id])

    if @account.update_attributes(account_params)
      redirect_to [ :accounts, @account ], :notice => 'Account updated'
    else
      render :edit
    end
  end

  private

  def set_groups
    if current_user.admin?
      @groups = Group.all.where(:id.in => WebAccount.group_ids)
    else
      @groups = current_user.groups.where(:id.in => WebAccount.group_ids)
    end
  end

  def account_params
    params.require(:web_account).permit(
      :title,
      :url,
      :username,
      :password,
      :comments,
      :tag_list
    ).merge(
      :last_updated_by_ip => request.remote_ip,
      :current_user => current_user
    )
  end
end
