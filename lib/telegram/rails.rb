module Telegram
  class Rails < Rails::Railtie
    initializer "telegram.configure_rails_initialization" do |app|
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
