class SoftwareLicense
  include Mongoid::Document
  include Mongoid::Document::Taggable
  include Mongoid::Timestamps

  field :title, :type => String
  field :license_key, :type => String
  field :licensed_to, :type => String
  field :comments, :type => String
  field :updated_by_ip, :type => String

  validates_presence_of :title, :license_key, :updated_by_ip
  validates_format_of :updated_by_ip, :with => /\A\d{0,3}\.\d{0,3}\.\d{0,3}\.\d{0,3}\z/
end
