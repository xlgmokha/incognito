require 'dotenv'
require 'pathname'
require 'twilio-ruby'

require 'incognito/sms'
require "incognito/version"

Dotenv.load(".env.local", Pathname.new(Dir.home).join(".incognitorc").to_s)

module Incognito
end
