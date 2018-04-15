module Incognito
  module CLI
    class Application < Thor
      desc 'sms SUBCOMMAND ...ARGS', 'SMS messaging.'
      subcommand :sms, SMSCommand

      desc 'version', 'display the version of the gem'
      def version
        say Incognito::VERSION
      end
    end
  end
end
