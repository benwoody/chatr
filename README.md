# chatr

[![Build Status](https://travis-ci.org/benwoody/chatr.png)](https://travis-ci.org/benwoody/chatr)

## Chatr Library
Chatr helps facilitate messages across socket connections.  When a new Chatr::Host object is created, it creates a TCPServer to marshal messaging to and from the connecting clients.

## chatr_host
This binary sets up a Chatr host connection.  Clients may then open connections to that hosts IP and Chatr port (default 4242)

Run host:

    chatr_host 3333

Connect to host:

    telnet 192.168.1.1 3333

The Host will accept the new connection and route incoming socket messages to the Host and other connected clients.
Clients are designated by their machines IP Address and the incoming Socket ID.
