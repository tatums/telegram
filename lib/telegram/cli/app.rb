require 'thor'

module Telegram
  module Cli
    class App < Thor

      desc 'hello NAME', 'Display greeting with given NAME'
      def hello(name)
        puts "Hello #{name}"
      end
    end
  end
end
