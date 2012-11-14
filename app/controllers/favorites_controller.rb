class FavoritesController < ApplicationController
  before_filter :authorize

  def index
    @web_accounts = current_user.favorites.where(:item_type => 'WebAccount').map(&:item)
    @generic_accounts = current_user.favorites.where(:item_type => 'GenericAccount').map(&:item)
    @licenses = current_user.favorites.where(:item_type => 'SoftwareLicense').map(&:item)
    @notes = current_user.favorites.where(:item_type => 'Note').map(&:item)
  end

  def create
    @item = get_item

    current_user.favorite!(@item)
    if params[:item_type] =~ /Account\z/
      redirect_to [ :accounts, @item ], :notice => "#{@item.title} added to favorites"
    else
      redirect_to @item, :notice => "#{@item.title} added to favorites"
    end
  end

  def destroy
    @item = get_item

    current_user.defavorite!(@item)
    redirect_to favorites_path, :notice => "#{@item.title} removed from favorites"
  end

  private

  def get_item
    params[:item_type].constantize.find(params[:item_id])
  end
end
