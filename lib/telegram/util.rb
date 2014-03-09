module Telegram
  class Util
    def self.setup_directories
      ["/telegram", "/telegram/messages", "/telegram/acknowledgments"].each do |path|
        full_path = Telegram.data_root + path
        Dir.mkdir(full_path) unless File.exists?(full_path)
      end
    end
  end
end
