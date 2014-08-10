require 'spec_helper'

module Telegram
  describe Util do

    describe "#setup_directories" do
      context "When directories exists" do
        it "should not create the directories" do
          File.stub(:exists?).and_return(true)
          expect(Dir).to_not receive(:mkdir)
          Telegram::Util.setup_directories
        end
      end

      context "When directories DOES NOT exist" do
        it "should create the directories" do
          File.stub(:exists?).and_return(false)
          expect(Dir).to receive(:mkdir).at_least(1).times
          Telegram::Util.setup_directories
        end
      end

    end

    describe "#create_config_file" do
      context "When a config/telegram.yml file does not exist" do
        it "returns creates a new file" do
          File.stub(:exists?).and_return(false)
          expect(File).to receive(:open)
          Telegram::Util.create_config_file
        end
      end
      context "When a config/telegram.yml file exists" do
        it "returns nil" do
          File.stub(:exists?).and_return(true)
          expect(File).to_not receive(:open)
          Telegram::Util.create_config_file
        end
      end
    end

  end
end
