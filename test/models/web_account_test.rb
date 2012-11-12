require 'minitest_helper'

describe WebAccount do
  it "will be valid with all required fields" do
    account = FactoryGirl.build(:web_account)
    account.must_be :valid?
    account.errors.must_be :empty?
  end

  it "wont be valid without username or password" do
    account1 = FactoryGirl.build(:web_account, :username => nil)
    account2 = FactoryGirl.build(:web_account, :password => nil)

    account1.wont_be :valid?
    account1.errors.has_key?(:username).must_equal true
    account2.wont_be :valid?
    account2.errors.has_key?(:password).must_equal true
  end
end
