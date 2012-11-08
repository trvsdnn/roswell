require 'minitest_helper'

describe WebAccount do
  it "creates an account if all require fields are given" do
    account = WebAccount.create(:title => 'An account', :username => 'guy', :password => 'secret', :last_updated_by_ip => '127.0.0.1')
    account.must_be :valid?
    account.errors.must_be :empty?
  end

  it "fails validation if missing username or password" do
    account1 = WebAccount.create(:title => 'An account', :password => 'secret', :last_updated_by_ip => '127.0.0.1')
    account2 = WebAccount.create(:title => 'An account', :username => 'guy', :last_updated_by_ip => '127.0.0.1')

    account1.wont_be :valid?
    account1.errors.wont_be :empty?
    account2.wont_be :valid?
    account2.errors.wont_be :empty?
  end

  it "fails validation if updated_by_ip isn't a valid ip" do
    %w[blah 123.123.123 3333.234.234.234 34s.23b.33d.234].each do |ip|
      account = WebAccount.create(:title => 'An account', :username => 'guy', :password => 'secret', :last_updated_by_ip => ip)
      account.wont_be :valid?
      account.errors.wont_be :empty?
    end
  end
end
