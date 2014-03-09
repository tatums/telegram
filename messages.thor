require 'telegram'
require "highline/import"
require 'pry'

class Messages < Thor
  desc "pending", "read pending messages"
  def pending
    system("clear")

    if (messages = Telegram::Message.not_acknowledged).any?
      choose do |menu|
        say('Pending Acknowledgements ->')
        menu.prompt = "\nWhich would you like to Acknowledge?"

        messages.each do |m|
          display_body = "#{m.created_at.strftime('%m/%d/%Y')} - #{m.body}"
          menu.choice(display_body) do
            m.acknowledge!
            say 'Message Acknowledged!'
          end
        end

        menu.choice('All') do
          messages.map(&:acknowledge!)
          say 'All Messages Acknowledged!'
        end
      end
    end
  end

end
