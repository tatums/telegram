module Telegram
  class Message
    include Virtus.model

    attribute :body, String
    attribute :user, String
    attribute :created_at, DateTime
    attribute :file_name, String

    def self.all
      Dir.glob("#{Telegram.messages_path}/*.yml").map do |file|
        self.new(
          YAML.load_file(file)
        )
      end
    end

    def self.not_acknowledged
      all.reject(&:acknowledged?)
    end

    def save
      File.open(file, "w") do |f|
        f.write(merged_attributes.to_yaml)
      end
    end

    def acknowledge!
      unless acknowledged?
        ack = Acknowledge.new(user: Telegram.user,
                              created_at: now,
                              file_name: file_name)
        ack.save
      end
    end

    def acknowledged?
      File.exists?(acknowledgment_file)
    end

    private

    def merged_attributes
      attributes.merge!(
        {
          user: Telegram.user,
          created_at: now,
          file_name: _file_name
        }
      )
    end

    def now
      @now ||= Time.now.utc.to_s
    end

    def _file_name
      @file_name ||= [ Time.now.utc.to_i, '.yml'].join
    end

    def file
      File.join(Telegram.messages_path, _file_name)
    end

    def acknowledgment_file
      File.join(Telegram.acknowledgments_path, file_name)
    end

  end
end

