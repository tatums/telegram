module Telegram
  class PendingMessageError < StandardError
    def initialize(count)
      super "\n\n\n You have #{count} pending Messages please run telegram \n\n\n"
    end
  end
end
