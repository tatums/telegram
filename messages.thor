require 'telegram'
require 'pry'

class Messages < Thor
  desc "pending", "read pending messages"
  def pending

    system("clear")
    messages = Message.all

    messages.each_with_index do |m, index|
      puts "#{index+1}:\t#{m.created_at.strftime("%m/%d/%Y")} - #{m.body}"
      print "\tAcknowledged by:"
      m.acknowledgments.each {|a|
        puts "#{a.user}"
      }
    end

  end
end
