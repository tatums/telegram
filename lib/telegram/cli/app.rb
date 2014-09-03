require "thor"
require "highline/import"
require "tzinfo"

module Telegram
  module Cli
    class App < Thor
      desc "all", "Display all messages"
      def all
        messages = Telegram::Message.all
        messages.each do |m|
          f_date = m.date_time.strftime("%m/%d/%Y at %r").colorize(:yellow)
          user = "[#{m.user}]".colorize(:blue)
          puts("#{f_date} #{m.body} #{user}" )
        end
        puts "#{messages.size} messages"
      end

      desc "pending", "Display all pending messages"
      def pending
        messages = Telegram::Message.not_acknowledged
        messages.each do |m|
          f_date = m.date_time.strftime("%m/%d/%Y at %r").colorize(:yellow)
          user = "[#{m.user}]".colorize(:blue)
          puts("#{f_date} #{m.body} #{user}" )
        end
        puts "#{messages.size} pending messages"
      end

      desc "future", "Display all future messages"
      def future
        messages = Telegram::Message.not_acknowledged(future: true)
        messages.each do |m|
          f_date = m.date_time.strftime("%m/%d/%Y at %r").colorize(:magenta)
          user = "[#{m.user}]".colorize(:blue)
          puts("#{f_date} #{m.body} #{user}" )
        end
        puts "#{messages.size} pending messages"
      end

      desc "new", "Create a new message"
      options :f => :numeric
      def new(body)
        args = Telegram::Message.excute_options(options).merge(body: body)
        Telegram::Message.new(args).save
        puts("Message created!")
      end

      desc "clear", "Clear all messages"
      def clear
        messages = Telegram::Message.not_acknowledged
        messages.each do |m|
          m.acknowledge!
        end
        puts "#{messages.size} messages cleared"
      end

      desc "install", "Installs telegram"
      def install
        Telegram::Util.setup_directories
        Telegram::Util.create_config_file
      end

      desc "console", "runs an interactive console"
      def console
        loop do
          choose do |menu|
            menu.shell  = true
            menu.prompt = "\nPlease choose an option.."

            Telegram::Message.not_acknowledged.each do |m|
              display_body = "#{m.date_time.strftime('%m/%d/%Y')} - #{m.body}"
              menu.choice(display_body) do
                m.acknowledge!
                say 'Message Acknowledged!'
              end
            end

            if Telegram::Message.not_acknowledged.size > 1
              menu.choice('All') do
                messages.map(&:acknowledge!)
                say 'All Messages Acknowledged!'
              end
            end

            menu.choice(:quit, "Exit program.") { exit }
          end
        end
      end
    end
  end
end
