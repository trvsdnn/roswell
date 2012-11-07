class WebAccount
  include Mongoid::Document
  include Mongoid::Document::Encryptable
  include Mongoid::Document::Taggable
  include Mongoid::Timestamps

  field :title, :type => String
  field :username, :type => String
  field :comments, :type => String
  field :updated_by_ip, :type => String

  encrypted_field :password, :key => Roswell::Application.config.secret_token

  validates_presence_of :title, :username, :encrypted_password, :updated_by_ip
  validates_format_of :updated_by_ip, :with => /\A\d{0,3}\.\d{0,3}\.\d{0,3}\.\d{0,3}\z/
end
