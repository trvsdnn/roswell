class GenericAccount
  include Mongoid::Document
  include Mongoid::Document::Taggable
  include Mongoid::Timestamps

  field :title, :type => String
  field :username, :type => String
  field :password, :type => String
  field :comments, :type => String
  field :updated_by_ip, :type => String

  validates_presence_of :title, :username, :password, :updated_by_ip
  validates_format_of :updated_by_ip, :with => /\A\d{0,3}\.\d{0,3}\.\d{0,3}\.\d{0,3}\z/
end
