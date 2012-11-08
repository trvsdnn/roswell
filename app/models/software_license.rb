class SoftwareLicense < BaseDocument

  field :title, :type => String
  field :licensed_to, :type => String
  field :comments, :type => String

  encrypted_field :license_key, :key => Roswell::Application.config.secret_token

  validates_presence_of :title, :encrypted_license_key
end
