require 'spec_helper'
describe Telegram do

  before do
    Telegram.configure do |config|
      config.user                 = "John"
      config.messages_path        = "tmp/messages"
      config.acknowledgments_path = "tmp/acks"
      config.time_zone            = "Pacific/Honolulu"
    end
  end

  describe "#user" do
    context "when the config specifies a user of `John`" do
      it "should return John" do
        expect(Telegram.user).to eq("John")
      end
    end
  end
  describe "#messages_path" do
    context "when the config specifies a messages_path of `tmp/messages`" do
      it "should return `tmp/messages`" do
        expect(Telegram.messages_path).to eq("tmp/messages")
      end
    end
  end
  describe "#acknowledgments_path" do
    context "when the config specifies a messages_path of `tmp/acks`" do
      it "should return `tmp/acks`" do
        expect(Telegram.acknowledgments_path).to eq("tmp/acks")
      end
    end
  end
  describe "#time_zone" do
    context "when the config specifies a time_zone of `Pacific/Honolulu`" do
      it "should return `Pacific/Honolulu`" do
        expect(Telegram.time_zone).to eq("Pacific/Honolulu")
      end
    end
  end
end
