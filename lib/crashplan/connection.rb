module Crashplan
  class Connection
    attr_accessor :host, :port, :scheme, :path_prefix, :username, :password, :adapter

    def initialize(options = {})
      @host        = options[:host]
      @port        = options[:port]
      @scheme      = options[:scheme]
      @path_prefix = options[:path_prefix]
      @username    = options[:username]
      @password    = options[:password]
      @adapter     = Faraday.new do |f|
        f.host = @host
        f.port = @port
        f.path_prefix = @path_prefix
        f.basic_auth(@username, @password)
      end
    end

    private

    def method_missing(method_name, *args, &block)
      return super unless adapter.respond_to?(method_name)
      adapter.send(method_name, *args, &block)
    end
  end
end