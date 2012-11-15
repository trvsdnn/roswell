require 'minitest_helper'

describe License do
  it "will be valid with all required fields" do
    license = FactoryGirl.build(:license)
    license.must_be :valid?
    license.errors.must_be :empty?
  end

  it "wont be valid without license_key" do
    license = FactoryGirl.build(:license, :license_key => nil)

    license.wont_be :valid?
    license.errors.has_key?(:license_key).must_equal true
  end

end
