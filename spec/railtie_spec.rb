require 'spec_helper'

require "dummy_rails/config/environment"

describe Telegram::Railtie do
  context "it has pending messages" do
    it "raises PendingMessageError" do

      Telegram::Message.stub(:not_acknowledged).and_return([5])

      expect{DummyRails::Application.initialize!}.to raise_error(Telegram::PendingMessageError)
    end
  end
  context "it does NOT have pending messages" do
  end
end
