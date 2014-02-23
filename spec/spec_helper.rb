require 'telegram'
require 'pry'

Telegram.configure { |config|
  config.user                 = "Tatum"
  config.messages_root        = File.join(Telegram.root, "/spec/fixtures/messages")
  config.acknowledgments_root = File.join(Telegram.root, "/spec/fixtures/acknowledgments")
}

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end
