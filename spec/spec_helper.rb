require 'rubygems'
require 'rspec'

RSpec.configure do |config|
  config.order = 'random'
end

require File.expand_path("../../lib/chatr", __FILE__)
