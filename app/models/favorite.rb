class Favorite
  include Mongoid::Document

  field :item_type, :type => String
  field :item_id, :type => String

  belongs_to :user

  # TODO: needs map reduce
  def item
    self.item_type.constantize.find(self.item_id)
  end

end
