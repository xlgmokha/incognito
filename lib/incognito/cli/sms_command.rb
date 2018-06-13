module Incognito
  module CLI
    class SMSCommand < Thor
      class_option :sid, desc: "Twilio SID. ENV['TWILIO_SID']", lazy_default: ENV['TWILIO_SID']
      class_option :token, desc: "Twilio token. ENV['TWILIO_TOKEN']", lazy_default: ENV['TWILIO_TOKEN']
      class_option :from_number, desc: "Twilio phone number. ENV['TWILIO_NUMBER']", default: ENV['TWILIO_NUMBER']
      class_option :debug, default: false, required: false

      desc 'message <PHONE_NUMBER> <MESSAGE>', "Send an SMS to the phone number. (+18005557777)"
      def message(phone_number, message)
        say "Sending `#{message}` to #{phone_number}"
        result = sms.send_message(to: phone_number, message: message)
        print_table [
          [:to, result.to],
          [:from, result.from],
          [:body, result.body],
          [:error, "#{result.error_code}: #{result.error_message}"],
          [:price, "#{result.price} #{result.price_unit}"],
          [:uri, result.uri],
        ]
      rescue Twilio::REST::TwilioError => error
        say error.message, :red
      end

      desc 'server', "Start a server"
      def server
        require 'incognito/sms_server'
        SmsServer.set :shell, self
        SmsServer.boot_up!
      end

      private

      def sms
        @sms ||= Sms.new(
          sid: options[:sid],
          token: options[:token],
          phone_number: options[:from_number]
        )
      end
    end
  end
end
