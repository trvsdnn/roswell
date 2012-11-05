class Note
  include Mongoid::Document
  include Mongoid::Document::Taggable
  include Mongoid::Timestamps

  field :title, :type => String
  field :body, :type => String
  field :updated_by_ip, :type => String

  validates_presence_of :title, :body, :updated_by_ip
  validates_format_of :updated_by_ip, :with => /\A\d{0,3}\.\d{0,3}\.\d{0,3}\.\d{0,3}\z/

  def self.tags
    _tags = []

    Note.collection.map_reduce(Tag.map, Tag.reduce, :out => 'note_tags').find.each do |result|
      next if result['value']['tags'].nil?

      result['value']['tags'].each do |tag|
        _tags << tag unless _tags.include?(tag)
      end
    end

    _tags
  end
end
