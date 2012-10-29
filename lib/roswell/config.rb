require 'yaml'
require 'singleton'

module Roswell
  class ConfigError < StandardError; end

  class Config
    include Singleton

    attr_accessor :environment
    attr_accessor :app_dir
    attr_accessor :domain

    # Airbrake
    attr_accessor :airbrake_api_key

    def initialize
      reset_config
    end

    def reset_config
      @environment   = :development
      @app_dir       = File.expand_path('../../../', __FILE__)
    end

    def development?
      @environment == :development
    end

    def production?
      @environment == :production
    end

    def testing?
      @environment == :testing
    end
  end
end
