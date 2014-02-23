# Telegram

A messageing tool.  This gem is mean to be added to a rack prodject where
you would need to communicate with a team of developers. 

## Installation

Add this line to your application's Gemfile:

    gem 'telegram'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install telegram

## Usage

Get all messages

```ruby
Message.all
=>[#<Message:0x00000101404ff0
  @body="blah test",
  @created_at=
   #<DateTime: 2014-02-12T02:53:58+00:00 ((2456701j,10438s,0n),+0s,2299161j)>,
  @file_name="1392173638.yml",
  @user="tatum">,
 #<Message:0x000001013ee778
  @body="hahahah ahahah ahaha",
  @created_at=
   #<DateTime: 2014-02-22T16:24:28+00:00 ((2456711j,59068s,0n),+0s,2299161j)>,
  @file_name="1393086268.yml",
  @user="tatum">]
```

Create a new Message

```ruby
message = Message.new(body: 'This is a test')
message.save
```

Acknowledge a message
```ruby
message = Message.all.find { |m| m.file_name == "1393086268.yml" }
message.acknowledge!
```

### Configuration
You can set the user, messages_root, and acknowlegments_root by passing the following block.
```ruby
Telegram.configure { |config|
  config.user                 = "Dr. Peter Venkman"
  config.messages_root        = File.join('.', "/data/messages")
  config.acknowledgments_root = File.join('.', "/data/acknowledgments")
}
```


## Contributing

1. Fork it ( http://github.com/<my-github-username>/telegram/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
