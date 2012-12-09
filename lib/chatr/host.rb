module Chatr
  class Host

    def initialize(port=4242)
      local = local_ip
      build_connection @local, port
      connections = grab_connections
    end

    # Find local ip
    def local_ip
      Socket.ip_address_list.last.ip_address
    end

    # Start Socket connection
    def build_connection(ip,port)
      @host = TCPServer.new(ip,port)
      @ost.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, 1)
    end

    # Builds an Array to store connections, adds current socket in 0
    def grab_connections
      @connections = []
      @connections << @host
    end

    # Take new socket from remote connection.
    # This will write out new information to the client and output this to the host as well
    def accept_new_connection
      newsock = @host.accept
      @connections.push(newsock)
      newsock.write("Write EOF to disconnect\n")
      str = sprintf "Client #{newsock.peeraddr[2]}:#{newsock.peeraddr[1]} joined.\n"
      broadcast_string(str,newsock)
    end

    # Writes out the clients information and chat string to both host and connected clients
    def write_out(string,sock)
      str = sprintf "[#{sock.peeraddr[2]}|#{sock.peeraddr[1]}]: #{string}"
      broadcast_string(str,sock)
    end

    # Writes out when a client writes EOF and then outputs that information to host and clients
    def client_quit(sock)
      str = sprintf "Client #{sock.peeraddr[2]}:#{sock.peeraddr[1]} disconnected\n"
      broadcast_string(str,sock)
      sock.close
      @connections.delete(sock)
    end

    # Print the string to the open connected sockets
    def broadcast_string(string,omit_sock)
      @connections.each do |client|
        if client != @host && client != omit_sock
          client.write(string)
        end
      end
      print(string)
    end

  end
end
