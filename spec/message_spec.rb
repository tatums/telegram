require 'spec_helper'

describe Message do
  describe 'Message#all' do
    before(:each) do
      Dir.stub(:glob).and_return(['spec/fixtures/example_1.yml'])
    end
    let(:messages) {Message.all}
    it 'should return an array' do
      expect(messages).to be_an_instance_of(Array)
    end
  end


  describe '#save' do

    let(:file) { double(File, write: true, close: nil ) }

    context "When a message with the body of test" do

      let(:message) { Message.new(body: 'test') }

      it 'should write a file and merge in additional keys' do
        File.should_receive(:open).and_return(file)
        file.should_receive(:write).with do |args|
          options = YAML::load(args)
          expect(options.keys).to include(:body)
          expect(options.keys).to include(:user)
          expect(options.keys).to include(:acknowledgments)
          expect(options.keys).to include(:created_at)
        end
        message.save
      end

    end

  end
end

