require "incognito/version"
require 'dotenv'
require 'twilio-ruby'
require 'pathname'

Dotenv.load(".env.local", Pathname.new(Dir.home).join(".incognitorc").to_s)

module Incognito
  class Sms
    def initialize(sid: ENV['TWILIO_SID'], token: ENV['TWILIO_TOKEN'], phone_number: ENV['TWILIO_NUMBER'])
      @sid = sid
      @token = token
      @phone_number = phone_number
    end

    def send(to:, message:)
      client.messages.create(body: message, from: phone_number, to: to)
    end

    private

    attr_reader :sid, :token, :phone_number

    def client
      @client ||= Twilio::REST::Client.new(sid, token)
    end
  end
end
