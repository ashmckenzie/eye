require 'engineyard-metadata'

module Ey
  class Servers

    def initialize env, force=false
      @env = env
      @force = force
      EY.metadata.environment_name = env
    end

    def app_master
      return @app_master if @app_master
      @app_master = servers 'app_master'
    end

    def app_servers
      return @app_servers if @app_servers
      @app_servers = servers 'app_servers'
    end

    def db_servers
      return @db_servers if @db_servers
      @db_servers = servers 'db_servers'
    end

    def db_master
      return @db_master if @db_master
      @db_master = servers 'db_master'
    end

    def servers type
      servers = [ *server_lookup(type) ].map do |hostname|
        Server.new hostname
      end
      servers
    end

    private

    def server_lookup type
      if !@force && File.exist?(cached_env_filename) && cached_env_file.send(type)
        cached_env_file.send(type)
      else
        data = {}
        servers = EY.metadata.send(type)

        begin
          data = cached_env_file
        rescue Errno::ENOENT
        end

        data['updated'] = Time.now.to_i
        data["#{type}"] = servers

        File.open(cached_env_filename, 'w') do |file|
          file.write(data.to_yaml)
        end

        servers
      end
    end

    def cached_env_file
      @cached_env_file ||= Hashie::Mash.new(YAML.load_file(cached_env_filename))
    end

    def cached_env_filename
      File.expand_path("../../../cache/#{@env}.yml", __FILE__)
    end
  end
end
