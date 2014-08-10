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
require "rails"
require "pry"
module Telegram

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :user,
                  :messages_path,
                  :acknowledgments_path,
                  :time_zone
  end

  def self.root
    File.expand_path("../..", __FILE__)
  end

  def self.user
    configuration.user
  end

  def self.messages_path
    configuration.try(:messages_path) || "telegram/messages"
  end

  def self.acknowledgments_path
    configuration.try(:acknowledgments_path) || "tmp/telegram/acknowledgments"
  end

  def self.time_zone
    configuration.try(:time_zone) || "America/Chicago"
  end


end


if settings = File.exists?("config/telegram.yml") && YAML.load_file("config/telegram.yml")
  Telegram.configure do |config|
    config.user                 = ENV['USER'] || ENV['USERNAME']
    config.messages_path        = File.expand_path(settings["messages_path"])
    config.acknowledgments_path = File.expand_path(settings["acknowledgments_path"])
  end
end

require 'telegram/rails' if defined?(Rails)

