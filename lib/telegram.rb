require 'yaml'
require 'virtus'
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

module Telegram

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :user, :messages_path, :acknowledgments_path
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
    configuration.try(:acknowledgments_path) || "tmp/telgram/acknowledgments"
  end
end

require 'telegram/rails' if defined?(Rails)

