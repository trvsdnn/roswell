require 'logger'

require 'roswell/config'

module Roswell

  def self.log(message)
    @@logger ||= Logger.new(STDOUT)
    @@logger.info(message)
  end

  def self.load_config
    return unless File.exist? config_file = File.join(Roswell.app_dir, 'config/config.yml')
    yaml = YAML.load_file(config_file)

    Roswell.configure do |config|
      yaml.each { |key, val| config.send("#{key}=", val) if config.respond_to?(key) }
    end
  end

  def self.configure
    config = Roswell::Config.instance
    block_given? ? yield(config) : config
  end

  Roswell::Config.public_instance_methods(false).each do |name|
    (class << self; self; end).class_eval <<-EOT
      def #{name}(*args)
        configure.send("#{name}", *args)
      end
    EOT
  end

end
