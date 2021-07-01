# Incognito

Send and Receive SMS messages from your terminal.

## Installation


Install it from https://rubygems.org:

    $ gem install incognito

Create an account at [twilio](https://www.twilio.com)

Configure the following settings in your shell profile.

    $ export TWILIO_SID="MYSID"
    $ export TWILIO_TOKEN="MYTOKEN"
    $ export TWILIO_NUMBER="MYNUMBER"

## Usage

To see the help:

    $ incognito help

To send an SMS to a specific phone #:

    $ incognito sms message +18005557777 "hello stranger!"

To send and receive SMS:

    $ incognito sms server # follow the onscreen instructions


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/xlgmokha/incognito.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
