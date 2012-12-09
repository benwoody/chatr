require 'socket'

class Host

  def initialize(port)
    local_ip = UDPSocket.open {|s| s.connect("64.233.187.99", 1); s.addr.last}
    @serverSocket = TCPServer.new(local_ip,port)
    @serverSocket.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, 1)
    puts "Chat server initiated at #{local_ip} on port #{port}"
    @connections = []
    @connections << @serverSocket
  end

  def run
    while true
      res = select(@connections,nil, nil,nil)
      if res != nil
        res[0].each do |sock|
          if sock == @serverSocket
            accept_new_connection
          else
            w = sock.gets
            if w.chomp == "EOF"
              client_quit sock
            else
              write_out w, sock
            end
          end
        end
      end
    end
  end

  private

  # Take new socket from remote connection.
  # This will write out new information to the client and output this to the host as well
  def accept_new_connection
    newsock = @serverSocket.accept
    @connections.push(newsock)
    newsock.write("Write EOF to disconnect\n")
    puts newsock.peeraddr
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
    @connections.each do |clisock|
      if clisock != @serverSocket && clisock != omit_sock
        clisock.write(string)
      end
    end
    print(string)
  end

end

mc = Host.new(9999).run
