require "minitest_helper"

describe BaseItem do
  before do
    @item = FactoryGirl.create(:base_item)
  end

  it "will be valid with all required fields" do
    @item.must_be :valid?
    @item.errors.must_be :empty?
  end

  it "wont be valid without a title" do
    item = FactoryGirl.build(:base_item, :title => nil)
    item.wont_be :valid?
    item.errors.has_key?(:title).must_equal true
  end

  it "wont be valid unless the user is a member of the requested groups" do
    @item.groups << FactoryGirl.create_list(:group, 3)
    @item.wont_be :valid?
    @item.errors[:base].first.must_match /groups are invalid/
  end

  it "will be valid if the user is a member of the requested groups" do
    @item.groups << @item.current_user.groups
    @item.must_be :valid?
    @item.errors.must_be :empty?
  end
end
