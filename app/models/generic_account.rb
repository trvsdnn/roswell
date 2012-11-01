class GenericAccount
  include Mongoid::Document
  include Mongoid::Document::Taggable
  include Mongoid::Timestamps

  field :title, :type => String
  field :username, :type => String
  field :password, :type => String
  field :comments, :type => String
  field :updated_by_ip, :type => String

  def self.tags
    _tags = []

    GenericAccount.collection.map_reduce(Tag.map, Tag.reduce, :out => 'generic_account_tags').find.each do |result|
      next if result['value']['tags'].nil?

      result['value']['tags'].each do |tag|
        _tags << tag unless _tags.include?(tag)
      end
    end

    _tags
  end
end
