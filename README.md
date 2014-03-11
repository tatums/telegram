# Telegram
A messageing tool.  This gem is mean to be added to a rack project where
you would need to communicate with a team.

## Installation

Add this line to your application's Gemfile:

    gem 'telegram'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install telegram


## Configuration

This gem will be looking for a config file.

create this file config/telegram.yml

you need to define two keys messages_path and acknowledgments_path

```
messages_path: "telegram/messages"
acknowledgments_path: "tmp/telegram/acknowledgments"
```

### Messages
When you create a message a yaml file is created. This file will be
commited to your git repo.

### Acknowledgments
When you acknowlege a message a file is created. This file does not get
commited to the repo.  It is important for this file/directory to be .gitignored


## Usage

This gem include a binary - so you can call telegram from the bash
prompt.


### All messages

```ruby
telegram all
```

Create a new Message

```ruby
telegram new "This is an important message."
Message created!
```

use the console
```ruby
telegram console

1. 03/11/2014 - This is an important message.
2. quit
3. help

Please choose an option..
```

### Configuration
You can set the user, messages_path, and acknowlegments_path by passing the following block.
```ruby
Telegram.configure { |config|
  config.user                 = "Dr. Peter Venkman"
  config.messages_path        = File.join('.', "/data/messages")
  config.acknowledgments_path = File.join('.', "/data/acknowledgments")
}
```


## Contributing

1. Fork it ( http://github.com/<my-github-username>/telegram/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
