class Note
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :type => String
  field :body, :type => String
  field :updated_by_ip, :type => String
end
