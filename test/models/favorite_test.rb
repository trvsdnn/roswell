require "minitest_helper"

describe Favorite do
  before do
    @favorite = Favorite.new
  end

  it "must be valid" do
    @favorite.valid?.must_equal true
  end
end
