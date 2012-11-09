class BaseDocument
  include Mongoid::Document
  include Mongoid::Document::Encryptable
  include Mongoid::Document::Taggable
  include Mongoid::Timestamps

  attr_accessor :current_user

  field :last_updated_by, :type => String
  field :last_updated_by_ip, :type => String

  has_and_belongs_to_many :groups, :inverse_of => nil

  before_validation :set_updated_by

  validates_presence_of :last_updated_by, :last_updated_by_ip
  validates_format_of :last_updated_by_ip, :with => /\A\d{0,3}\.\d{0,3}\.\d{0,3}\.\d{0,3}\z/

  validate :validate_tags

  private

  def validate_tags
    invalid_tags = []

    self.tags.each do |tag|
      invalid_tags << tag if self.class.tags.include?(tag) && !current_user.allowed_tags.include?(tag)
    end

    errors.add(:base, "You don't have permission to use the following tags: `#{invalid_tags.join(',')}'") unless invalid_tags.empty?
  end

  def set_updated_by
    self.last_updated_by = current_user.id
  end
end
