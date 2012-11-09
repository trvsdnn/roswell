require "minitest_helper"

describe Group do
  before do
    @group = Group.new
  end

  it "must be valid" do
    @group.valid?.must_equal true
  end
end
