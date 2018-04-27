module Incognito
  class Sms
    def initialize(sid:, token:, phone_number:)
      @sid = sid
      @token = token
      @phone_number = phone_number
    end

    def send_message(to:, message:)
      client.messages.create(body: message, from: phone_number, to: to)
    end

    private

    attr_reader :sid, :token, :phone_number

    def client
      @client ||= Twilio::REST::Client.new(sid, token)
    end
  end
end
