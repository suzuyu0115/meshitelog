require 'line/bot'

class LineClient
  def initialize
    @client = Line::Bot::Client.new do |config|
      config.channel_secret = ENV.fetch("LINE_MESSAGING_CHANNEL_SECRET", nil)
      config.channel_token = ENV.fetch("LINE_MESSAGING_CHANNEL_TOKEN", nil)
    end
  end

  def push_message(user_id, message)
    message = {
      type: 'text',
      text: message
    }

    @client.push_message(user_id, message)
  end
end
