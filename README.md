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

### Timezone

```
["America/New_York",
 "America/Detroit",
 "America/Kentucky/Louisville",
 "America/Kentucky/Monticello",
 "America/Indiana/Indianapolis",
 "America/Indiana/Vincennes",
 "America/Indiana/Winamac",
 "America/Indiana/Marengo",
 "America/Indiana/Petersburg",
 "America/Indiana/Vevay",
 "America/Chicago",
 "America/Indiana/Tell_City",
 "America/Indiana/Knox",
 "America/Menominee",
 "America/North_Dakota/Center",
 "America/North_Dakota/New_Salem",
 "America/North_Dakota/Beulah",
 "America/Denver",
 "America/Boise",
 "America/Phoenix",
 "America/Los_Angeles",
 "America/Anchorage",
 "America/Juneau",
 "America/Sitka",
 "America/Yakutat",
 "America/Nome",
 "America/Adak",
 "America/Metlakatla",
 "Pacific/Honolulu"]
```


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
When you create a message a yml file is created in telegram/messages. This file will be
commited to your git repo with your code.  When another developer pulls down your code, they will also receive your message file.  The next time they use the app. They will need to acknowlege your message before they can continue.  

### Acknowledgments
When you acknowlege a message a file is created. This file does not get
commited to the repo.  It is important for this file/directory to be .gitignored



## Contributing

1. Fork it ( http://github.com/<my-github-username>/telegram/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
