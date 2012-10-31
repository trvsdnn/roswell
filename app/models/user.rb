class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  has_secure_password

  field :email, :type => String
  field :password_digest, :type => String
  field :updated_by_ip, :type => String
  field :last_login_at, :type => Time

  validates_presence_of :email
  validates_uniqueness_of :email, :case_sensitive => false

  index :email, :unique => true
end
