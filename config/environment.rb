APP_ROOT = File.expand_path('../../', __FILE__)
$LOAD_PATH.unshift(File.join(APP_ROOT, 'lib'))

ENV['RACK_ENV'] ||= 'development'

require 'yaml'

require 'mongoid'
require 'json'

require 'roswell'

Dir.glob("#{APP_ROOT}/app/models/*.rb") { |route| require route }

Roswell.load_config
Roswell.environment = ENV['RACK_ENV'].to_sym


if Roswell.production?
  require 'airbrake'

  Airbrake.configure do |config|
    config.api_key = Roswell.airbrake_api_key
  end
end

if defined? Sinatra
  require 'sinatra/content_for'
  require "#{APP_ROOT}/app/helpers"

  class Roswell::Application < Sinatra::Base
    enable :logging
    enable :show_exceptions if development?

    if production?
      use Airbrake::Rack
      enable :raise_errors
    end


    set :root,  APP_ROOT
    set :views, lambda { File.join(root, 'app/views') }
    set :protection, :except => :frame_options

    helpers Sinatra::ContentFor
    helpers Roswell::ApplicationHelpers
  end

  Dir.glob("#{APP_ROOT}/app/routes/*.rb") { |route| require route }
end
