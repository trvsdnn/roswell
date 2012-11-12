require 'minitest_helper'

describe Note do
  it "will be valid with all required fields" do
    note = FactoryGirl.build(:note)
    note.must_be :valid?
    note.errors.must_be :empty?
  end

  it "wont be valid without a body field" do
    note = FactoryGirl.build(:note, :body => nil)
    note.wont_be :valid?
    note.errors.has_key?(:body).must_equal true
  end

end
