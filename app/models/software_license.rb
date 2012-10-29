class SoftwareLicense
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :type => String
  field :license_key, :type => String
  field :licensed_to, :type => String
  field :comments, :type => String
  field :updated_by_ip, :type => String
end
