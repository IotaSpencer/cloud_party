# frozen_string_literal: true
require 'etc'
require 'app_configuration'
module CloudParty
  class Config
    def initialize
      cp_config = AppConfiguration.new('config') do
        base_local_path Pathname.new(Dir.home).join('.cloud_party/')
        base_global_path Pathname.new(Etc.sysconfdir).join('cloud_party')
        use_env_variables true
        prefix 'CLOUD_PARTY'
      end
      cfcli_config = AppConfiguration.new('config') do
        base_local_path Pathname.new(Dir.home).join('.cfcli/')
        base_global_path Pathname.new(Etc.sysconfdir).join('cloudflare_cli')
        use_env_variables true
        prefix 'CFCLI'
      end
      @@email = cp_config.email || cfcli_config.email
      @@api_key = cp_config.api_key || cfcli_config.api_key
      @@token = cp_config.token || cfcli_config.token
    end

    # @return [String] the email string
    def self.email
      @@email
    end

    # @return [String] the api key string
    def self.api_key
      @@api_key
    end

    # @return [String] the cloudflare api token
    def self.token
      @@token
    end
  end
end
