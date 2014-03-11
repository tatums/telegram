module Telegram
  class Util
    def self.setup_directories
      [Telegram.messages_path, Telegram.acknowledgments_path].each do |path|
        Dir.mkdir(path) unless File.exists?(path)
      end
    end
  end
end
