require 'sinatra'
require 'sinatra/base'
require 'ngrok/tunnel'

class SmsServer < Sinatra::Base
  PORT=ENV.fetch("PORT", 4567)
  configure do
    disable :logging
    set :server, :puma
    set :shell, $shell
    set :port, PORT
  end

  get '/' do
    content_type 'text/xml'
    Incognito.logger.debug(params.inspect)

    shell.say "To: #{params["To"]}", :green
    shell.say "From: #{params["From"]}", :green
    shell.say "Message: #{params["Body"]}", :green
    if shell.yes? "Reply?"
      Twilio::TwiML::MessagingResponse.new do |response|
        response.message(body: shell.ask("Response:"))
      end.to_s
    else
      Twilio::TwiML::MessagingResponse.new do |response|
      end.to_s
    end
  end

  def self.boot_up!
    Ngrok::Tunnel.start(addr: "localhost:#{PORT}")
    puts "***" * 10
    banner = <<-BANNER
Configure your webhook URL
For Twilio to know where to look, you need to configure your Twilio phone number
to call your webhook URL whenever a new message comes in.

1. Log into twilio.com and go to the Numbers page in the Console.
  (https://www.twilio.com/console/phone-numbers/incoming)
2. Click on your SMS-enabled phone number.
3. Find the Messaging section. The default “CONFIGURE WITH” is what you’ll need: "Webhooks/TwiML."
4. In the “A MESSAGE COMES IN” section, select "Webhook" and paste in the URL you want to use:
#{Ngrok::Tunnel.ngrok_url_https}
5. Set the HTTP verb to GET.


    BANNER
    puts banner
    puts "***" * 10
    run!
  end

  private

  def shell
    settings.shell
  end
end
