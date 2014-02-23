require 'yaml'
require 'virtus'

require "telegram/version"
require "telegram/acknowledge"
require "telegram/user"
require "telegram/message"


module Telegram

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :user, :messages_root, :acknowledgments_root
  end

  def self.root
    File.expand_path("../..", __FILE__)
  end

  def self.user
    configuration.user
  end

  def self.messages_root
    configuration.messages_root
  end

  def self.acknowledgments_root
    configuration.acknowledgments_root
  end

  Telegram.configure { |config|
    config.user                 = ENV['USER'] || ENV['USERNAME']
    config.messages_root        = File.join(root, "/data/messages")
    config.acknowledgments_root = File.join(root, "/data/acknowledgments")
  }

end
