require "minitest_helper"

describe BaseDocument do
  before do
    @base_document = BaseDocument.new
  end

  it "must be valid" do
    @base_document.valid?.must_equal true
  end
end
