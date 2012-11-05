require 'minitest_helper'

describe SoftwareLicense do
  it "creates a license if all require fields are given" do
    license = SoftwareLicense.create(:title => 'A license', :license_key => 'abckey23', :updated_by_ip => '127.0.0.1')
    license.must_be :valid?
    license.errors.must_be :empty?
  end

  it "fails validation if missing license_key" do
    license = SoftwareLicense.create(:body => 'Some words', :updated_by_ip => '127.0.0.1')

    license.wont_be :valid?
    license.errors.wont_be :empty?
  end

  it "fails validation if updated_by_ip isn't a valid ip" do
    %w[blah 123.123.123 3333.234.234.234 34s.23b.33d.234].each do |ip|
      license = SoftwareLicense.create(:title => 'A license', :license_key => 'abckey23', :updated_by_ip => ip)
      license.wont_be :valid?
      license.errors.wont_be :empty?
    end
  end
end
