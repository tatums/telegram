module Telegram
  class PendingMessageError < StandardError
    def initialize(count)
      super [
              "\n\n",
              "You have #{count.to_s.colorize(:red)} pending Messages.\n\n",
              "please acknowledge these message by running #{"`bundle exec telegram console`".colorize(:red)} from the command line\n",
              `bundle exec telegram help`,
              "For more info on telegram. Please visit #{'https://github.com/Homestyle/telegram'.colorize(:blue)}",
              "\n\n"
            ].join("\n")
    end
  end
end
