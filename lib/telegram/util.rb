module Telegram
  class Util

    def self.valid_install?
      File.exists?("config/telegram.yml")
    end

    def self.setup_directories
      [Telegram.messages_path, Telegram.acknowledgments_path].each do |path|
        FileUtils::mkdir_p(path) unless File.exists?(path)
      end
    end

    def self.create_config_file
      file = "config/telegram.yml"
      if File.exists?(file)
        puts "File config/telegram.yml already exists."
      else
        File.open(file, "w") do |f|
          f.write({messages_path:         "telegram/messages",
                    acknowledgments_path: "tmp/telegram/acknowledgments",
                    timezone:             "America/Chicago"}.to_yaml)

        end
        puts "created file config/telegram.yml."
      end
    end

  end
end
