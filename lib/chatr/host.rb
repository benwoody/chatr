module Chatr
  class Host

    attr_reader :host, :connections

    def initialize(port=4242)
      @host = build_connection local_ip, port
      @connections = grab_connections
    end

    # Find local ip
    # This attempts an open connection to google.com and checks the local address used to attempt the request
    def local_ip
      UDPSocket.open {|s| s.connect("64.233.187.99", 1); s.addr.last}
    end

    # Start Socket connection
    def build_connection(ip,port)
      TCPServer.new(ip,port)
    end

    # Builds an Array to store connections, adds current socket in 0
    def grab_connections
      connections = []
      connections << @host
    end

    # Gives the number of connected clients
    # Subtracts 1 to account for the host
    def room_size
      @connections.size - 1
    end

    # Take new socket from remote connection.
    # This will write out new information to the client and output this to the host as well
    def accept_new_connection
      new_socket = @host.accept
      @connections << new_socket
      new_socket.write("Write QUIT to disconnect\n")
    end

    # Writes out when a client writes EOF and then outputs that information to host and clients
    def client_quit(socket)
      @connections.delete(socket)
      socket.close
    end

    # Print the string to the open connected sockets
    def broadcast_string(string,origin)
      @connections.each do |client|
        if client != @host && client != origin
          client.write(string)
        end
      end
      print(string)
    end

  end
end
