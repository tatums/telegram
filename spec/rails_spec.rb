require 'spec_helper'
require "rails"
require "telegram/rails"

describe Telegram::Rails do
  before do
    Telegram.configure do |config|
      config.user      = "Tatum"
      config.messages_path        = "telegram/messages"
      config.acknowledgments_path = "tmp/telegram/acknowledgments"
    end
  end

  context "it has pending messages" do
    it "raises PendingMessageError" do
      allow(Telegram::Message).to receive(:not_acknowledged).and_return([5])
      expect{
        load "dummy_rails/config/environment.rb"
      }.to raise_error(
        Telegram::PendingMessageError
      )
    end
  end
  context "it does NOT have pending messages" do
   it "does NOT raise PendingMessageError" do
      allow(Telegram::Message).to receive(:not_acknowledged).and_return([])
      expect{
        load "dummy_rails/config/environment.rb"
      }.not_to raise_error
    end
  end
end
