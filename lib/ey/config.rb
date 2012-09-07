module Ey
  class Config

    def self.valid_environments
      @valid_environments ||= config.valid_environments
    end

    def self.valid_ssh_environments
      @valid_ssh_environments ||= config.valid_ssh_environments
    end

    def self.valid_types
      @valid_types ||= config.valid_types
    end

    def self.config
      @config_file ||= Hashie::Mash.new(YAML.load_file(config_filename))
    end

    def self.config_filename
      File.expand_path("../../../config/config.yml", __FILE__)
    end
    end
end
