require 'dotenv'
require 'logger'
require 'pathname'
require 'twilio-ruby'

require 'incognito/sms'
require "incognito/version"

Dotenv.load(".env.local", Pathname.new(Dir.home).join(".incognitorc").to_s)

module Incognito
  def self.logger
    @logger ||= Logger.new(STDOUT)
  end
end
