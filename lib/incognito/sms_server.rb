require 'sinatra'
require 'sinatra/base'

class SmsServer < Sinatra::Base
  configure do
    disable :logging
    set quiet: true, b: 2
  end

  get '/' do
    content_type 'text/xml'
    Incognito.logger.debug(params.inspect)

    $shell.say "To: #{params["To"]}", :green
    $shell.say "From: #{params["From"]}", :green
    $shell.say "Message: #{params["Body"]}", :green
    if $shell.yes? "Reply?"
      Twilio::TwiML::MessagingResponse.new do |response|
        response.message(body: $shell.ask("What is your response?"))
      end.to_s
    else
      Twilio::TwiML::MessagingResponse.new do |response|
      end.to_s
    end
  end
end
