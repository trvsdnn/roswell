class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  has_secure_password

  attr_accessor :allowed_tags_list

  field :email, :type => String
  field :password_digest, :type => String
  field :last_login_at, :type => Time
  field :allowed_tags, :type => Array, :default => []
  field :admin, :type => Boolean, :default => false

  index :email, :unique => true

  validates_presence_of :email
  validates_uniqueness_of :email, :case_sensitive => false

  before_save :set_allowed_tags

  private

  def set_allowed_tags
    if allowed_tags_list
      self.allowed_tags = allowed_tags_list.split(',').compact
    else
      self.allowed_tags = nil
    end
  end

end
