class GenericAccount < BaseItem

  field :username, :type => String
  field :comments, :type => String

  encrypted_field :password, :key => Roswell::Application.config.secret_token

  validates_presence_of :username

end
