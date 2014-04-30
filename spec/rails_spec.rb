require 'spec_helper'

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

      Telegram::Message.stub(:not_acknowledged).and_return([5])
      expect{
        require "dummy_rails/config/environment"
      }.to raise_error(
        Telegram::PendingMessageError
      )
    end
  end
  context "it does NOT have pending messages" do
   it "does NOT raise PendingMessageError" do
      Telegram::Message.stub(:not_acknowledged).and_return([])
      expect{
        require "dummy_rails/config/environment"
      }.not_to raise_error
    end
  end
end
