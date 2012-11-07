require 'minitest_helper'

class TestDoc
  include Mongoid::Document
  include Mongoid::Document::Encryptable

  encrypted_field :password, :key => 'a secret'
end

describe Mongoid::Document::Encryptable do
  it "encrypts a secure field on save" do
    clear_password = 'something secret'
    doc = TestDoc.create(:password => clear_password)

    doc.reload

    doc.password.must_equal clear_password
    doc.encrypted_password.wont_equal clear_password
  end

  it "raises an error if an encrypted_field is created without a key" do
    lambda {
      class TestDoc
        include Mongoid::Document
        include Mongoid::Document::Encryptable

        encrypted_field :password
      end
    }.must_raise Mongoid::Document::Encryptable::NoKeyError
  end
end
