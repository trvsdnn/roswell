class Accounts::WebAccountsController < ApplicationController
  before_filter :authorize

  def index
    if current_user.admin
      @accounts = WebAccount.all
    elsif current_user.allowed_tags.nil?
      @accounts = WebAccount.where(:tags => [] )
    else
      @accounts = WebAccount.any_of({ :tags.in => current_user.allowed_tags }, { :tags => [] })
    end
  end

  def tagged
    @tag = params[:tag]
    @accounts = WebAccount.tagged_with(@tag)
    render :template => 'accounts/web_accounts/index'
  end

  def new
    @account = WebAccount.new
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
