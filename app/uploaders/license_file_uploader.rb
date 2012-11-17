# encoding: utf-8

class LicenseFileUploader < CarrierWave::Uploader::Base

  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  storage :grid_fs

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    asset_path("fallback/" + [version_name, "default-photo.png"].compact.join('_'))
  end

end
