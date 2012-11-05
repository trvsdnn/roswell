class Accounts::GenericAccountsController < ApplicationController
  before_filter :authorize

  def index
    if current_user.admin
      @accounts = GenericAccount.all
    elsif current_user.allowed_tags.nil?
      @accounts = GenericAccount.where(:tags => [] )
    else
      @accounts = GenericAccount.any_of({ :tags.in => current_user.allowed_tags }, { :tags => [] })
    end
  end

  def tagged
    @tag = params[:tag]
    @accounts = GenericAccount.tagged_with(@tag)
    render :template => 'accounts/generic_accounts/index'
  end

  def new
    @account = GenericAccount.new
  end

  def create
    @account = GenericAccount.new(account_params)

    if @account.save
      redirect_to [ :accounts, @account ], :notice => 'Account created'
    else
      render :new
    end
  end

  def show
    @account = GenericAccount.find(params[:id])
  end

  def edit
    @account = GenericAccount.find(params[:id])
  end

  private

  def account_params
    params.require(:generic_account).permit(:title, :username, :password, :comments, :tag_list)
  end
end
