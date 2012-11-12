class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  has_secure_password

  field :username, :type => String
  field :password_digest, :type => String
  field :last_login_at, :type => Time
  field :allowed_tags, :type => Array, :default => []
  field :admin, :type => Boolean, :default => false

  index :username, :unique => true

  has_and_belongs_to_many :groups

  validates_presence_of :username
  validates_uniqueness_of :username, :case_sensitive => false

end
