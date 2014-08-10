require 'spec_helper'
module Telegram
  describe Middleware do
    context "it has pending messages" do
      it "raises PendingMessageError" do
        Telegram::Message.stub(:not_acknowledged).and_return([5])
        expect{
          described_class.new(Class.new)
        }.to raise_error(
          Telegram::PendingMessageError
        )
      end
    end

    context "it does NOT have pending messages" do
     it "does NOT raise PendingMessageError" do
        Telegram::Message.stub(:not_acknowledged).and_return([])
        expect{
          described_class.new(Class.new)
        }.not_to raise_error
      end
    end
  end
end
