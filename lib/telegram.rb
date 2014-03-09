require 'yaml'
require 'virtus'

require "telegram/util"
require "telegram/version"
require "telegram/acknowledge"
require "telegram/user"
require "telegram/message"
require "telegram/middleware"
require "telegram/cli/app"

module Telegram

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :user, :data_root
  end

  def self.user
    configuration.user
  end

  def self.root
    File.expand_path("../..", __FILE__)
  end

  def self.data_root
    configuration.data_root
  end

  def self.messages_root
    File.join(data_root + "/telegram/messages")
  end

  def self.acknowledgments_root
    File.join(data_root + "/telegram/acknowledgments")
  end

  ## DOC - These are setting the defaults for development
  ## They will be changed when added to an app.
  Telegram.configure { |config|
    config.user                 = ENV['USER'] || ENV['USERNAME']
    config.data_root            = File.join(root, "/data/telegram")
  }

end

require 'telegram/railtie' if defined?(Rails)

