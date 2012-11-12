class WebAccount < BaseItem

  field :url, :type => String
  field :username, :type => String
  field :comments, :type => String

  encrypted_field :password, :key => Roswell::Application.config.secret_token

  validates_presence_of :username

end
