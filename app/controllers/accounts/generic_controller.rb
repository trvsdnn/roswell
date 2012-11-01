class Accounts::GenericController < ApplicationController
  before_filter :authorize

  def index
    @accounts = GenericAccount.all
    render :template => 'accounts/index'
  end

  def tagged
    @accounts = GenericAccount.tagged_with(params[:tag])
    render :template => 'accounts/index'
  end

  def new
    @account = GenericAccount.new
  end

  def create
    @account = GenericAccount.new(account_params)

    if @account.save
      redirect_to @note, :notice => 'Account created'
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
