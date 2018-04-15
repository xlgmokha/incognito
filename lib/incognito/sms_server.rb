require 'sinatra'
require 'sinatra/base'

class SmsServer < Sinatra::Base
  get '/' do
    content_type 'text/xml'

    Twilio::TwiML::VoiceResponse.new do |response|
      response.say("hello?")
    end.to_s
  end
end
