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
  has_many :favorites

  validates_presence_of :username
  validates_uniqueness_of :username, :case_sensitive => false

  def has_favorite?(item)
    favorites.where(:item_id => item._id).first
  end

  def favorite!(item)
    favorite = Favorite.new(:item_type => item.class.name, :item_id => item.id)
    self.favorites << favorite
    self.save
  end

  def defavorite!(item)
    self.favorites.where(:item_id => item._id).destroy
    self.save
  end

end
