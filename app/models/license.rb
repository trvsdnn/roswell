class License < BaseItem

  field :licensed_to, :type => String
  field :comments, :type => String

  encrypted_field :license_key, :key => Roswell::Application.config.roswell_key

end
