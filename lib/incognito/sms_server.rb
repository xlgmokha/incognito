require 'sinatra'
require 'sinatra/base'

class SmsServer < Sinatra::Base
  configure do
    disable :logging
    set quiet: true, b: 2
    set :server, :puma
    set :shell, $shell
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

  private

  def shell
    settings.shell
  end
end
