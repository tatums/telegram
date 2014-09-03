require 'rack/response'

module Telegram
  class Middleware
    def initialize(app)
      pending_message_stop
      @app = app
    end

    def call(env)
      req = Rack::Request.new(env)
      if req.post?
        file_name = req.params["message_file_name"]
        message = Message.all.find { |f| f.file_name == file_name }
        message.acknowledge!
        response = Rack::Response.new
        response.redirect "/"
        response.finish
      else
        messages = Message.not_acknowledged
        if messages.any?
          items = messages.map do |m|
            "<li>
                From: #{m.user}<br />
                Date: #{m.created_at.strftime("%m/%d/%Y at %l:%M %P")}
                <p>#{m.body}</p>
                <form action='telegram' method='POST'>
                  <input type=hidden name='message_file_name' value=#{m.file_name}>
                  <input type='submit' value='Ack!'>
                </form>
            </li>"
          end.join
          [200, {"Content-Type" => "text/html"}, [ body(items) ] ]
        else
          @app.call(env)
        end
      end
    end

    private

      def pending_message_stop
        messages = Message.not_acknowledged
        if messages.any?
          raise PendingMessageError.new(messages.length)
          exit!
        end
      end


      def body(items)
        <<-HTML
          <html>
            <head>
              <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootswatch/3.1.1/united/bootstrap.min.css">
              <style>
                  body{
                      background-color: #E6E6E6;
                      margin:0.5em;
                      }

                  ul{ margin:0;
                      padding:0;
                  }

                  ul li {
                      margin: 0.5em 0;
                      list-style: none;
                      padding: 0.7em;
                      background: #fff;
                      -webkit-border-radius: 3px;
                      -moz-border-radius: 3px;
                      border-radius: 3px;
                      -webkit-box-shadow: 0 1px 2px rgba(0,0,0,0.07);
                      -moz-box-shadow: 0 1px 2px rgba(0,0,0,0.07);
                      box-shadow: 0 1px 2px rgba(0,0,0,0.07);
                  }
              </style>
            </head>
            <body>
            <h1>You have pending messages.</h1>
            <ul>
              #{items}
            </ul>
            <div>
              <p>You can clear these messages using Telegram from the terminal.</p>
              <p><a href="https://github.com/tatums/telegram">View the read me on Github.</a>
            </div>
          </body>
          </html>
        HTML
      end

  end
end
