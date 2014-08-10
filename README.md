# Telegram
A messageing tool.  This gem is meant to be added to a rack project where
you would need to communicate with a team.

## Installation

Add this line to your application's Gemfile:

    gem 'telegram'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install telegram


Install config/telegram.yml and other folders

    $ telegram install


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


##How does it work?

### Messages
When you create a message a yaml file is created. This file will be
commited to your git repo.

### Acknowledgments
When you acknowlege a message a file is created. This file does not get
commited to the repo.  It is important for this file/directory to be .gitignored



## Contributing

1. Fork it ( http://github.com/<my-github-username>/telegram/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
