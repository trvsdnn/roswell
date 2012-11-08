class BaseDocument
  include Mongoid::Document
  include Mongoid::Document::Encryptable
  include Mongoid::Document::Taggable
  include Mongoid::Timestamps

  attr_accessor :current_user

  field :last_updated_by, :type => String
  field :last_updated_by_ip, :type => String

  before_validation :set_updated_by

  validates_presence_of :last_updated_by, :last_updated_by_ip
  validates_format_of :last_updated_by_ip, :with => /\A\d{0,3}\.\d{0,3}\.\d{0,3}\.\d{0,3}\z/

  private

  def set_updated_by
    self.last_updated_by = current_user
  end
end
