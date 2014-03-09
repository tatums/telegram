module Telegram
  class Railtie < Rails::Railtie
    initializer "telegram.configure_rails_initialization" do |app|
      Telegram.configure { |config|
        config.data_root = File.join(Rails.root, "/tmp")
      }
      Telegram::Util.setup_directories
      app.middleware.use Middleware
    end
  end
end
