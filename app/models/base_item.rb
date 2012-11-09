class BaseItem
  include Mongoid::Document
  include Mongoid::Document::Encryptable
  include Mongoid::Timestamps

  attr_accessor :current_user

  field :last_updated_by, :type => String
  field :last_updated_by_ip, :type => String

  has_and_belongs_to_many :groups, :inverse_of => nil

  before_validation :set_updated_by

  validates_presence_of :last_updated_by, :last_updated_by_ip
  validates_format_of :last_updated_by_ip, :with => /\A\d{0,3}\.\d{0,3}\.\d{0,3}\.\d{0,3}\z/

  validate :groups_are_allowed

  def self.group_ids
    all.only(:group_ids).collect{ |ms| ms.group_ids }.flatten.uniq
  end

  private

  def groups_are_allowed
    return if groups.empty? || current_user.admin?

    invalid_groups = []
    groups.each do |group|
      unless current_user.groups.include?(group)
        invalid_groups << group.name
      end
    end

    errors.add(:base, "The following groups are invalid `#{invalid_groups.join(', ')}'") unless invalid_groups.empty?
  end

  def set_updated_by
    self.last_updated_by = current_user.id
  end
end
