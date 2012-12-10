require 'spec_helper'

describe 'Host' do

	before :all do
		@chatr = Chatr::Host.new
	end

	it 'should find local ip address' do
		ip_regex = /^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$/
		@chatr.local_ip.should match ip_regex
	end

	it 'should build a Socket connection' do
	end

	it 'should accept new connections' do
	end

	it 'should broadcast information accross connections' do
	end

	it 'should write chat lines accross connections' do
	end

	it 'should close a connection when a client quits' do
	end

end
