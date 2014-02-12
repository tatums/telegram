require 'spec_helper'

describe Message do
  describe 'Message#all' do
    before(:each) do
      Dir.stub(:glob).and_return(['spec/fixtures/example_1.yml'])
    end
    let(:messages) { Message.all }
    it 'should return an array' do
      expect(messages).to be_an_instance_of(Array)
    end
  end

  describe '#save' do
    let(:file) { double(File, write: true, close: nil) }

    context "When a message with the body of test" do
      let(:message) { Message.new(body: 'test') }
      it 'should write a file and merge in additional keys' do
        File.should_receive(:open).and_return(file)

        file.should_receive(:write).with do |args|
          options = YAML::load(args)
          [:body, :user, :acknowledgments, :created_at].each do |item|
            expect(options.keys).to include(item)
          end
        end
        message.save
      end
    end

    describe '#acknowledge' do
      before(:each) do
        Dir.stub(:glob).and_return(['spec/fixtures/example_1.yml'])
      end
      let(:message) { Message.all.first }
      it 'should NOT change the created_at date' do
        expect{ message.ack }.not_to change{ message.created_at }
      end
    end

  end
end

