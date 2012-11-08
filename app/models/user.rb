class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  has_secure_password

  attr_accessor :allowed_tags_list

  field :username, :type => String
  field :password_digest, :type => String
  field :last_login_at, :type => Time
  field :allowed_tags, :type => Array, :default => []
  field :admin, :type => Boolean, :default => false

  index :username, :unique => true

  validates_presence_of :username
  validates_uniqueness_of :username, :case_sensitive => false

  before_save :set_allowed_tags

  private

  def set_allowed_tags
    if allowed_tags_list
      self.allowed_tags = allowed_tags_list.split(',').compact
    else
      self.allowed_tags = []
    end
  end

end
