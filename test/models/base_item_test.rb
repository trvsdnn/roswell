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

  it "wont be valid without last_updated_by" do
    item = FactoryGirl.build(:base_item, :current_user => nil)
    item.wont_be :valid?
    item.errors.has_key?(:last_updated_by).must_equal true
  end

  it "wont be valid without a proper last_updated_by_ip" do
    item = FactoryGirl.build(:base_item, :last_updated_by_ip => nil)
    item.wont_be :valid?
    item.errors.has_key?(:last_updated_by_ip).must_equal true

    %w[blah 123.123.123 3333.234.234.234 34s.23b.33d.234].each do |ip|
      item = FactoryGirl.build(:base_item, :last_updated_by_ip => ip)
      item.wont_be :valid?
      item.errors.has_key?(:last_updated_by_ip).must_equal true
    end
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
