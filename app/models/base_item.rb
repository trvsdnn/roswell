class BaseItem
  include Mongoid::Document
  include Mongoid::Document::Encryptable
  include Mongoid::Timestamps

  attr_accessor :current_user

  field :title, :type => String

  has_and_belongs_to_many :groups, :inverse_of => nil

  validates_presence_of :title

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
end
