require 'yaml'
require 'virtus'

require "telegram/version"
require "telegram/acknowledge"
require "telegram/user"
require "telegram/message"


module Telegram

  def self.user
    ENV['USER'] || ENV['USERNAME']
  end

  def self.lib_root
    File.dirname(__FILE__)
  end

  def self.messages
    Dir.glob("#{data_root}*.yml").map do |file|
      YAML.load_file(file)
    end
  end

  def self.file
    File.open(file_location, "r")
  end

  def self.file_location
    "#{lib_root}/../data/messages.yml"
  end

  def self.data_root
    "#{lib_root}/../data/"
  end
end
