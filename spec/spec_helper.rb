require 'telegram'
require 'pry'


if !defined?(Rails)
  Telegram.configure do |config|
    config.user      = "Tatum"
    config.messages_path        = "spec/fixtures/telegram/messages"
    config.acknowledgments_path = "spec/fixtures/telegram/acknowledgments"
  end
end


RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end
