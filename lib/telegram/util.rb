module Telegram
  class Util

    def self.valid_install?
      File.exists?("config/telegram.yml")
    end

    def self.setup_directories
      [Telegram.messages_path, Telegram.acknowledgments_path, "./config"].each do |path|
        if File.exists?(path)
          puts "#{path}".colorize(:yellow) + " already exists."
        else
          FileUtils::mkdir_p(path)
          puts "#{path}".colorize(:green) + " created."
        end
      end
    end

    def self.create_config_file
      file = "config/telegram.yml"
      if File.exists?(file)
        puts "#{file}".colorize(:yellow) + " already exists."
      else
        File.open(file, "w") do |f|
          f.write({ user:                  Telegram.user,
                    messages_path:         Telegram.messages_path,
                    acknowledgments_path:  Telegram.acknowledgments_path,
                    timezone:              Telegram.time_zone}.to_yaml)

        end
        puts "#{file}".colorize(:green) + " created."
      end
    end

  end
end
