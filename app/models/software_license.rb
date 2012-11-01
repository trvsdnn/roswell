class SoftwareLicense
  include Mongoid::Document
  include Mongoid::Document::Taggable
  include Mongoid::Timestamps

  field :title, :type => String
  field :license_key, :type => String
  field :licensed_to, :type => String
  field :comments, :type => String
  field :updated_by_ip, :type => String

  def self.tags
    _tags = []

    SoftwareLicense.collection.map_reduce(Tag.map, Tag.reduce, :out => 'software_license_tags').find.each do |result|
      next if result['value']['tags'].nil?

      result['value']['tags'].each do |tag|
        _tags << tag unless _tags.include?(tag)
      end
    end

    _tags
  end
end
