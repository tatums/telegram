module Telegram
  class Message
    OPTION_ATTRIBUTES = {
      "f" => "future"
    }


    include Virtus.model

    attribute :body, String
    attribute :user, String
    attribute :created_at, DateTime
    attribute :file_name, String
    attribute :future, Time

    def self.all
      Dir.glob("#{Telegram.messages_path}/*.yml").map do |file|
        self.new(
          YAML.load_file(file)
        )
      end
    end

    def self.not_acknowledged(for_future: false)
      if for_future
        #operator = for_future ? :select : :reject
        all.select{|m|  m.future}.select{ |m| m.future > m.now }
      else
        all.reject {|m| m.acknowledged? }.reject{ |m| (m.future || m.now) > m.now }
      end
    end

    def self.future(integer)
      ## Convert integer to days
      Time.now + (integer * 86400)
    end

    def self.excute_options(options)
      hash = {}
      options.each do |k,v|
        lookup = OPTION_ATTRIBUTES[k]
        hash.merge!(lookup.to_sym => send(lookup, v))
      end
      hash
    end

    def date_time
      zone = TZInfo::Timezone.get(Telegram.time_zone)
      zone.utc_to_local(future || created_at)
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

    def now
      @now ||= Time.now.utc
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

    def get_message_time
      time = future ? future : Time.now
      time.utc.to_i
    end

    def _file_name
      # @file_name ||= [ Time.now.utc.to_i, '.yml'].join
      @file_name ||= [ get_message_time, '.yml'].join
    end

    def file
      File.join(Telegram.messages_path, _file_name)
    end

    def acknowledgment_file
      File.join(Telegram.acknowledgments_path, file_name)
    end

  end
end

