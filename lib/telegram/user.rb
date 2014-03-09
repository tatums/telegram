module Telegram
  class User
    include Virtus.model
    attribute :name, String
  end
end
