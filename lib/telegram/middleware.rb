module Telegram
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      messages = Message.not_acknowledged
      if messages.any?

        items = messages.map{ |m|
          "<li>
              From: #{m.user}<br />
              Date: #{m.created_at.strftime("%m/%d/%Y at %l:%M %P")}
              <p>#{m.body}</p>
          </li>"
        }.join

        [200, {"Content-Type" => "text/html"}, [ body(items) ] ]
      else
        @app.call(env)
      end
    end

    private

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
