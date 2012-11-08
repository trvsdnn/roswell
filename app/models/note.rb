class Note < BaseDocument

  field :title, :type => String
  field :body, :type => String

  encrypted_field :body, :key => Roswell::Application.config.secret_token

  validates_presence_of :title

end
