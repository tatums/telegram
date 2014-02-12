class Message
  include Virtus.model

  attribute :body, String
  attribute :user, String
  attribute :acknowledgments, Array[Acknowledge]
  attribute :created_at, DateTime

  attr_accessor :file_name

  def self.all
    Dir.glob("#{Telegram.data_root}*.yml").map do |file|
      self.new(
        YAML.load_file(file)
      )
    end
  end

  def save
    x = file
    x.write(merged_attributes.to_yaml)
    x.close
  end

  def ack
    unless acknowledgments.map(&:user).include?(Telegram.user)
      acknowledgments.push(
        Acknowledge.new(
          user: Telegram.user,
          created_at: now)
      )
      self.save
    end
  end

  private

  def merged_attributes
    attributes.merge!(
      {
        user: Telegram.user,
        created_at: _created_at,
        file_name: file_name
      }
    )
  end

  def _created_at
    created_at || now
  end

  def now
    Time.now.utc.to_s
  end

  def file_name
    @file_name ||= [ Time.now.utc.to_i, '.yml'].join
  end

  def file
    File.open(
      [Telegram.data_root, file_name].join, 'w+'
    )
  end

end
