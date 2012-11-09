require "minitest_helper"

describe BaseItem do
  before do
    @base_document = BaseItem.new
  end

  it "must be valid" do
    @base_document.valid?.must_equal true
  end
end
