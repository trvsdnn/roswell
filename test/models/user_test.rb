require "minitest_helper"

describe User do
  before do
    @user = FactoryGirl.create(:user)
  end

  it "favorites an item" do
    web_account = FactoryGirl.create(:web_account)
    note        = FactoryGirl.create(:note)

    @user.favorites.must_be :empty?

    @user.favorite(web_account)
    @user.favorite(note)
    @user.reload

    @user.favorites.size.must_equal 2
  end

  it "defavorites an item" do
    web_account = FactoryGirl.create(:web_account)
    note        = FactoryGirl.create(:note)

    @user.favorites.must_be :empty?

    @user.favorite(web_account)
    @user.favorite(note)
    @user.reload
    @user.defavorite(note)
    @user.reload

    @user.favorites.has_key?(web_account._id.to_s).must_equal true
    @user.favorites.has_key?(note._id.to_s).must_equal false
    @user.favorites.size.must_equal 1
  end

end
