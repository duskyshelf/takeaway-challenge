require 'twilio-ruby'

class Texter

  def initialize 
    account_sid = ENV['account_sid']
    auth_token  = ENV['auth_token']
    @client      = Twilio::REST::Client.new account_sid, auth_token
  end

  def self.send_message time
    new.send_message time
  end

  def send_message time
    @client.messages.create(
      from: '+441772368127',
      to: '+447552768118',
      body: "Thank you! Your order was placed and will be delivered before #{time.hour}:#{time.min}")
  end

end
