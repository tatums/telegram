class Acknowledge
  include Virtus.model

  attribute :user, String
  attribute :created_at, DateTime
  attribute :file_name, String

  def save
    File.open(file, "w") do |f|
      f.write(merged_attributes.to_yaml)
    end
  end

  private

  def file
    File.join(Telegram.acknowledgments_root, file_name)
  end

  def merged_attributes
    attributes.merge!(
      {
        user: Telegram.user,
        created_at: now
      }
    )
  end

  def now
    @now ||= Time.now.utc.to_s
  end

end
