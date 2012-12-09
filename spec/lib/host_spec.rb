require 'spec_helper'

describe 'Host' do

	before :all do
		@chatr = Chatr::Host.new
	end

	it 'should find local ip address' do
		ip_from_google = UDPSocket.open {|s| s.connect("64.233.187.99", 1); s.addr.last}
		@chatr.local_ip.should == ip_from_google
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
