require 'sinatra'
require 'sinatra/base'

class SmsServer < Sinatra::Base
  get '/' do
    content_type 'text/xml'

    Twilio::TwiML::MessagingResponse.new do |response|
      response.message(body: "It's a me... Mario!")
    end.to_s
  end
end
