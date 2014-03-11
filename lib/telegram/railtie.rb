module Telegram
  class Railtie < Rails::Railtie
    initializer "telegram.configure_rails_initialization" do |app|
      Telegram::Util.setup_directories
      app.middleware.use Middleware
    end
  end
end
