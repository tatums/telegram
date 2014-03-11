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

  end
end
