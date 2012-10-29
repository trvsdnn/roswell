require 'rubygems'
require 'bundler/setup'
require 'sinatra/base'
require File.expand_path('../config/environment', __FILE__)

class Roswell::Application < Sinatra::Base
  set :run, lambda { __FILE__ == $0 && !running? }

  # Handle Errors in Production
  if production?
    not_found do
      File.read File.join(settings.root, 'public/404.html')
    end

    error do
      File.read File.join(settings.root, 'public/500.html')
    end
  end

  run! if run?
end