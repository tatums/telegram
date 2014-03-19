module Telegram
  class PendingMessageError < StandardError
    def initialize(count)
      super "\n\n\n You have #{count} pending Messages please run telegram \n\n\n"
    end
  end
  class Railtie < Rails::Railtie
    initializer "telegram.configure_rails_initialization" do |app|
      Telegram::Util.setup_directories
      app.middleware.use Middleware
    end

    initializer "telegram.pending_messages" do |app|
      messages = Message.not_acknowledged
      if messages.any?
        raise PendingMessageError.new(messages.length)
        exit!
      end
    end

  end
end
