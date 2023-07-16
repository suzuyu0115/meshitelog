require 'line/bot'

class LineClient
  def initialize
    @client = Line::Bot::Client.new do |config|
      config.channel_secret = ENV["LINE_MESSAGING_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_MESSAGING_CHANNEL_TOKEN"]
    end
  end

  def push_message(user_id, message)
    message = {
      type: 'text',
      text: message
    }

    response = @client.push_message(user_id, message)
  end
end
