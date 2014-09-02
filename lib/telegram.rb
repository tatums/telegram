require "yaml"
require "tzinfo"
require "virtus"
require "colorize"
require "fileutils"

require "telegram/util"
require "telegram/version"
require "telegram/acknowledge"
require "telegram/user"
require "telegram/message"
require "telegram/middleware"
require "telegram/cli/app"
require "telegram/pending_message"
require "pry"
module Telegram

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||=
      Configuration.new(messages_path: "telegram/messages",
                        acknowledgments_path: "tmp/telegram/acknowledgments",
                        timezone: "America/Chicago")
  end

  class Configuration
    attr_accessor :user,
                  :messages_path,
                  :acknowledgments_path,
                  :time_zone

    def initialize(settings)
      settings = YAML.load_file("config/telegram.yml") if File.exists?("config/telegram.yml")
      @user = ENV['USER'] || ENV['USERNAME']
      @messages_path = settings[:messages_path]
      @acknowledgments_path = settings[:acknowledgments_path]
      @time_zone = settings[:timezone]
    end
  end

  def self.root
    File.expand_path("../..", __FILE__)
  end

  def self.user
    configuration.user
  end

  def self.messages_path
    configuration.messages_path
  end

  def self.acknowledgments_path
    configuration.acknowledgments_path
  end

  def self.time_zone
    configuration.time_zone
  end
end

Telegram.configure

if defined?(Rails)
  require 'telegram/rails'
  require "rails"
end
