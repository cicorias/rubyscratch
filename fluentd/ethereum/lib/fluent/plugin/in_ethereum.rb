require 'fluent/plugin/input'

module Fluent::Plugin
  class EthereumTelemetry < Input
    # First, register the plugin. NAME is the name of this plugin
    # and identifies the plugin in the configuration file.
    Fluent::Plugin.register_input('ethereum', self)

    # config_param defines a parameter. You can refer a parameter via @port instance variable
    # :default means this parameter is optional
    config_param :port, :integer, default: 8888
    config_param :ws_user, :string, default: 'geth'
    config_param :ws_pass, :string, default: 'password'
    desc 'The bind address to listen to.'
    config_param :bind, :string, default: '0.0.0.0'

    #potentiall for reading the geth log
    # desc "The Path of the file."
    config_param :logfile, :string, default: nil

    # This method is called before starting.
    # 'conf' is a Hash that includes configuration parameters.
    # If the configuration is invalid, raise Fluent::ConfigError.
    def configure(conf)
      super
      log.debug "configure called..."
      # You can also refer to raw parameter via conf[name].
      @port = conf['port']
      #...

      log.info "configure with #{conf.inspect}"
    end

    # This method is called when starting.
    # Open sockets or files and create a thread here.
    def start
      super
      #...
      log.debug "start called..."
    end

    # This method is called when shutting down.
    # Shutdown the thread and close sockets or files here.
    def shutdown
      super
      #...
      log.debug "shutdown called..."
    end
  end
end

