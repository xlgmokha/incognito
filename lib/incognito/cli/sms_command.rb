module Incognito
  module CLI
    class SMSCommand < Thor
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
        $shell = self
        SmsServer.run!
      end

      private

      def sms
        @sms ||= Sms.new
      end
    end
  end
end
