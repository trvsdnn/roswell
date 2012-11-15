class GenericAccount < BaseItem

  field :username, :type => String
  field :comments, :type => String

  encrypted_field :password, :key => Roswell::Application.config.roswell_key

  validates_presence_of :username

end
