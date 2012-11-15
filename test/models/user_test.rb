require "minitest_helper"

describe User do
  before do
    @user = FactoryGirl.create(:user)
  end

  it "favorites an item" do
    web_account = FactoryGirl.create(:web_account)
    note        = FactoryGirl.create(:note)

    @user.favorites.must_be :empty?

    @user.favorite!(web_account)
    @user.favorite!(note)
    @user.reload

    @user.has_favorite?(web_account).wont_be_nil
    @user.has_favorite?(note).wont_be_nil
    @user.favorites.size.must_equal 2
  end

  it "defavorites an item" do
    web_account = FactoryGirl.create(:web_account)
    note        = FactoryGirl.create(:note)

    @user.favorites.must_be :empty?

    @user.favorite!(web_account)
    @user.favorite!(note)
    @user.reload
    @user.defavorite!(note)
    @user.reload

    @user.has_favorite?(web_account).wont_be_nil
    @user.has_favorite?(note).must_be_nil
    @user.favorites.size.must_equal 1
  end

end
