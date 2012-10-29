class GenericAccount
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :type => String
  field :username, :type => String
  field :password, :type => String
  field :comments, :type => String
  field :updated_by_ip, :type => String
end
