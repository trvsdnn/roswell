class Note < BaseItem

  field :body, :type => String

  encrypted_field :body, :key => Roswell::Application.config.secret_token

end
