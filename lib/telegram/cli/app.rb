require "thor"
require "pry"
require "highline/import"

module Telegram
  module Cli
    class App < Thor
      desc "all", "Display all messages"
      def all
        messages = Telegram::Message.all
        messages.each do |m|
          f_date = m.created_at.strftime("%m/%d/%Y at %l:%M%P").colorize(:yellow)
          user = "[#{m.user}]".colorize(:blue)
          puts("#{f_date} #{m.body} #{user}" )
        end
      end

      desc "pending", "Display all messages"
      def pending
        messages = Telegram::Message.not_acknowledged
        messages.each do |m|
          f_date = m.created_at.strftime("%m/%d/%Y at %l:%M%P").colorize(:yellow)
          user = "[#{m.user}]".colorize(:blue)
          puts("#{f_date} #{m.body} #{user}" )
        end
      end

      desc "new", "Create a new message"
      def new(body)
        Telegram::Message.new(body: body).save
        puts("Message created!")
      end

      desc "console", "runs an interactive console"
      def console
        loop do
          choose do |menu|
            menu.shell  = true
            #say('Pending Acknowledgements ->')
            menu.prompt = "\nPlease choose an option.."

            Telegram::Message.not_acknowledged.each do |m|
              display_body = "#{m.created_at.strftime('%m/%d/%Y')} - #{m.body}"
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
