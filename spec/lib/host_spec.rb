require 'spec_helper'

describe 'Host' do

	before :all do
		@chatr = Chatr::Host.new
	end

	it 'should find local ip address' do
		ip_regex = /^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$/
		@chatr.local_ip.should match ip_regex
	end

	it 'should build an Array of socket connections' do
		@chatr.grab_connections.class.should be Array
	end

	it 'should show the number of clients in chat' do
		@chatr.room_size.class.should be Fixnum
	end

	# Tests that a TCPServer connection is built
	it 'should build a Socket connection' do
		@chatr.host.class.should be TCPServer
	end

	it 'should accept new connections' do
		client = TCPSocket.new(@chatr.local_ip,'4242')
		@chatr.accept_new_connection
		@chatr.room_size.should eq(1)
		@chatr.client_quit @chatr.connections.last
	end

	it 'should close a connection when a client quits' do
		client = TCPSocket.new(@chatr.local_ip,'4242')
		@chatr.accept_new_connection
		@chatr.client_quit @chatr.connections.last
		@chatr.room_size.should eq(0)
	end

end
