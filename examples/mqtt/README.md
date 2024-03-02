# mqtt (IoT)
This example demonstrates encrypting container traffic between an mqtt
broker and a client both subscribing and publishing to an arbitrary topic

## Getting Started

```
$ git clone https://github.com/ironcladencryption/ice.git
$ cd ice/examples/mqtt
$ ./build.sh
$ docker-compose up
```

That's it!  The trusted network is now encrypting tcp traffic amongst
the two containers.

The terminal will produce output similar to the following:  

```
Starting mqtt_broker_1 ...
Starting mqtt_broker_1 ... done
Starting mqtt_client_1 ...
Starting mqtt_client_1 ... done
Attaching to mqtt_broker_1, mqtt_client_1
broker_1  | Unlinking stale socket /var/run/supervisor.sock
broker_1  |
broker_1  |     ____          ______      __
broker_1  |    /  _/_______  / ____/_  __/ /_  ___
broker_1  |    / // ___/ _ \/ /   / / / / __ \/ _ \
broker_1  |  _/ // /__/  __/ /___/ /_/ / /_/ /  __/
broker_1  | /___/\___/\___/\____/\__,_/_.___/\___/
broker_1  |
broker_1  | ice version:    0.2.3
broker_1  | iceman version:     0.3.0
broker_1  |
broker_1  | crypto strategy:    fernet
broker_1  | encryption enabled: True
broker_1  |
broker_1  |     role   | protocol | port
broker_1  |     ______ | ________ | _____
broker_1  |     server | tcp      | 1883
broker_1  |
broker_1  | 1510566504: mosquitto version 1.4.8 (build date Mon, 26 Jun 2017 09:31:02 +0100) starting
broker_1  | 1510566504: Config loaded from /mqtt/config/mosquitto.conf.
broker_1  | 1510566504: Opening ipv4 listen socket on port 1883.
client_1  | Unlinking stale socket /var/run/supervisor.sock
client_1  |
client_1  |     ____          ______      __
client_1  |    /  _/_______  / ____/_  __/ /_  ___
client_1  |    / // ___/ _ \/ /   / / / / __ \/ _ \
client_1  |  _/ // /__/  __/ /___/ /_/ / /_/ /  __/
client_1  | /___/\___/\___/\____/\__,_/_.___/\___/
client_1  |
client_1  | ice version:    0.2.3
client_1  | iceman version:     0.3.0
client_1  |
client_1  | crypto strategy:    fernet
client_1  | encryption enabled: True
client_1  |
client_1  |     role   | protocol | port
client_1  |     ______ | ________ | _____
client_1  |     client | tcp      | 1883
client_1  |
broker_1  | 1510566508: New connection from 172.19.0.3 on port 1883.
broker_1  | 1510566508: New client connected from 172.19.0.3 as mosqsub/21-19d51940df73 (c1, k60).
broker_1  | 1510566508: New connection from 172.19.0.3 on port 1883.
broker_1  | 1510566508: New client connected from 172.19.0.3 as mosqpub/22-19d51940df73 (c1, k60).
client_1  |
client_1  | ################ sleeping for 2 seconds ##################
client_1  |
broker_1  | 1510566508: Client mosqpub/22-19d51940df73 disconnected.
client_1  | test/topic hello world
```

### Inspection
Run the following command to inspect container traffic:  

```$ docker exec -it --privileged mqtt_broker_1 tcpdump -nl -A 'port 1883'```

The terminal will produce output similar to the following:  

```
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
09:51:05.481291 IP 172.19.0.3.56866 > 172.19.0.2.1883: Flags [S], seq 1900728920, win 29200, options [mss 1460,sackOK,TS val 4586526 ecr 0,nop,wscale 7], length 0
E..<.F@.@..J.........".[qJ.X......r.X?.........
.E..........
09:51:05.483595 IP 172.19.0.2.1883 > 172.19.0.3.56866: Flags [S.], seq 3823524984, ack 1900728921, win 28960, options [mss 1460,sackOK,TS val 4586526 ecr 4586526,nop,wscale 7], length 0
E..<..@.@............[."..\xqJ.Y..q .[.........
.E...E......
09:51:05.485598 IP 172.19.0.3.56866 > 172.19.0.2.1883: Flags [.], ack 1, win 229, options [nop,nop,TS val 4586526 ecr 4586526], length 0
E..4.G@.@..Q.........".[qJ.Y..\y.....b.....
.E...E..
09:51:05.492205 IP 172.19.0.3.56866 > 172.19.0.2.1883: Flags [P.], seq 1:141, ack 1, win 229, options [nop,nop,TS val 4586526 ecr 4586526], length 140
E....H@.@............".[qJ.Y..\y....[......
.E...E..gAAAAABaCWsJIXu1AhchxOPwGjC8LFMEBRiRBZwcspFMp7rvcs-1WAeTODt4-R_4Kezlov0n1szbUPVmIIa8GJ0d1iobE0jvTISuRBEYqAOf7C-ovC0rFYBGmDUjOOqslcItiXs8YzYx
09:51:05.497155 IP 172.19.0.2.1883 > 172.19.0.3.56866: Flags [.], ack 40, win 227, options [nop,nop,TS val 4586527 ecr 4586526], length 0
E..4.g@.@.B1.........[."..\yqJ.......<.....
.E...E..
09:51:05.501977 IP 172.19.0.2.1883 > 172.19.0.3.56866: Flags [P.], seq 1:101, ack 40, win 227, options [nop,nop,TS val 4586527 ecr 4586526], length 100
E....h@.@.A..........[."..\yqJ.............
.E...E..gAAAAABaCWsJtVhpwx9OOohkP5ptpFgHDKVhsL7BKTE1Jr0X_Xolx_WD5_dwEJqmNWgN1RjdxGRfCY6ChxKXea7v6JfKomr6Uw==
09:51:05.506808 IP 172.19.0.3.56866 > 172.19.0.2.1883: Flags [.], ack 5, win 229, options [nop,nop,TS val 4586528 ecr 4586527], length 0
E..4.I@.@..O.........".[qJ....\}.....4.....
.E. .E..
09:51:05.512120 IP 172.19.0.3.56866 > 172.19.0.2.1883: Flags [P.], seq 40:160, ack 5, win 229, options [nop,nop,TS val 4586528 ecr 4586527], length 120
E....J@.@............".[qJ....\}...........
.E. .E..gAAAAABaCWsJWjJi_vpEKeOlLJhoP1vQUH6pnCD8DWmLp5uO8jVKYBaKVTexFs3mY4qcNBK4WxqJ6hGyAQlQb-S2YDy3py-7K6qj74Ora0DA00RYBMZEYwQ=
09:51:05.515491 IP 172.19.0.3.56866 > 172.19.0.2.1883: Flags [FP.], seq 65:165, ack 5, win 229, options [nop,nop,TS val 4586528 ecr 4586527], length 100
E....K@.@............".[qJ....\}.....&.....
.E. .E..gAAAAABaCWsJiQA8hS8OUKdaG7z3EO3EKe_xbcILfDm1vzze64PpSppsRgqM1yFyiq9jWb5QkOixzhGIEOp87KlIu4bWL4mbWQ==
09:51:05.519249 IP 172.19.0.2.1883 > 172.19.0.3.56552: Flags [P.], seq 3013451567:3013451687, ack 2730360409, win 227, options [nop,nop,TS val 4586529 ecr 4586326], length 120
E...J&@.@............[...../...Y.....3.....
.E.!.E.VgAAAAABaCWsJjjK5nJsJKhjksiv67f0ax15PSz2JISRr-dodGm2QTwd-fNmvTJt9ffbtD9mROU-TfFE52jiB_tU-8rmQUoy9BQRIzzWx5jwLW8IZv-eYJ88=
09:51:05.519937 IP 172.19.0.2.1883 > 172.19.0.3.56866: Flags [.], ack 68, win 227, options [nop,nop,TS val 4586529 ecr 4586528], length 0
E..4.i@.@.B/.........[."..\}qJ.............
.E.!.E.
09:51:05.520393 IP 172.19.0.2.1883 > 172.19.0.3.56866: Flags [F.], seq 5, ack 68, win 227, options [nop,nop,TS val 4586529 ecr 4586528], length 0
E..4.j@.@.B..........[."..\}qJ.............
.E.!.E.
09:51:05.524939 IP 172.19.0.3.56552 > 172.19.0.2.1883: Flags [.], ack 25, win 229, options [nop,nop,TS val 4586530 ecr 4586529], length 0
E..4,.@.@..............[...Y...H....L......
.E.".E.!
09:51:05.526839 IP 172.19.0.3.56866 > 172.19.0.2.1883: Flags [.], ack 6, win 229, options [nop,nop,TS val 4586530 ecr 4586529], length 0
E..47.@.@............".[qJ....\~...........
.E.".E.!
```
observe the encrypted packet payload captures

### Verification
By default the containers encrypt network traffic.  To see what
network traffic looks like unencrypted, edit [base.env](base.env) and change
`ICE_ENCRYPTION_ENABLED=False`.  __This is recommended for development
purposes only.__

Restart the network:  

```$ docker-compose down && docker-compose up```

Inspect the traffic:  

```$ docker exec -it --privileged mqtt_broker_1 tcpdump -nl -A 'port 1883'```

The terminal will produce output similar to the following:  

```
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
09:52:40.607608 IP 172.19.0.3.57144 > 172.19.0.2.1883: Flags [S], seq 426611916, win 29200, options [mss 1460,sackOK,TS val 4596038 ecr 0,nop,wscale 7], length 0
E..<..@.@.-..........8.[.m........r..j.........
.F!F........
09:52:40.611252 IP 172.19.0.2.1883 > 172.19.0.3.57144: Flags [S.], seq 2564263026, ack 426611917, win 28960, options [mss 1460,sackOK,TS val 4596039 ecr 4596038,nop,wscale 7], length 0
E..<..@.@............[.8...r.m....q .r.........
.F!G.F!F....
09:52:40.613719 IP 172.19.0.3.57144 > 172.19.0.2.1883: Flags [.], ack 1, win 229, options [nop,nop,TS val 4596039 ecr 4596039], length 0
E..4..@.@.-..........8.[.m.....s.... y.....
.F!G.F!G
09:52:40.619391 IP 172.19.0.3.57144 > 172.19.0.2.1883: Flags [P.], seq 1:40, ack 1, win 229, options [nop,nop,TS val 4596039 ecr 4596039], length 39
E..[..@.@.,..........8.[.m.....s....Z......
.F!G.F!G.%..MQIsdp...<..mosqpub/40-cbff27e9b4b4
09:52:40.625263 IP 172.19.0.2.1883 > 172.19.0.3.57144: Flags [.], ack 40, win 227, options [nop,nop,TS val 4596040 ecr 4596039], length 0
E..4.4@.@.5d.........[.8...s.m...... S.....
.F!H.F!G
09:52:40.628632 IP 172.19.0.2.1883 > 172.19.0.3.57144: Flags [P.], seq 1:5, ack 40, win 227, options [nop,nop,TS val 4596040 ecr 4596039], length 4
E..8.5@.@.5_.........[.8...s.m.......E.....
.F!H.F!G ...
09:52:40.632179 IP 172.19.0.3.57144 > 172.19.0.2.1883: Flags [.], ack 5, win 229, options [nop,nop,TS val 4596041 ecr 4596040], length 0
E..4..@.@.-..........8.[.m.....w.... K.....
.F!I.F!H
09:52:40.635467 IP 172.19.0.3.57144 > 172.19.0.2.1883: Flags [P.], seq 40:65, ack 5, win 229, options [nop,nop,TS val 4596041 ecr 4596040], length 25
E..M..@.@.,..........8.[.m.....w....n......
.F!I.F!H0..
test/topichello world
09:52:40.640244 IP 172.19.0.2.1883 > 172.19.0.3.57112: Flags [P.], seq 949911227:949911252, ack 3755250313, win 227, options [nop,nop,TS val 4596041 ecr 4595838], length 25
E..M`.@.@............[..8.~................
.F!I.F ~0..
test/topichello world
09:52:40.643135 IP 172.19.0.3.57144 > 172.19.0.2.1883: Flags [FP.], seq 65:67, ack 5, win 229, options [nop,nop,TS val 4596041 ecr 4596040], length 2
E..6..@.@.-..........8.[.m.....w....@&.....
.F!I.F!H..
09:52:40.648946 IP 172.19.0.2.1883 > 172.19.0.3.57144: Flags [.], ack 68, win 227, options [nop,nop,TS val 4596042 ecr 4596041], length 0
E..4.6@.@.5b.........[.8...w.m...... /.....
.F!J.F!I
09:52:40.653263 IP 172.19.0.2.1883 > 172.19.0.3.57144: Flags [F.], seq 5, ack 68, win 227, options [nop,nop,TS val 4596042 ecr 4596041], length 0
E..4.7@.@.5a.........[.8...w.m...... ......
.F!J.F!I
09:52:40.654466 IP 172.19.0.3.57112 > 172.19.0.2.1883: Flags [.], ack 25, win 229, options [nop,nop,TS val 4596042 ecr 4596041], length 0
E..4..@.@.S............[....8.~......H.....
.F!J.F!I
09:52:40.656229 IP 172.19.0.3.57144 > 172.19.0.2.1883: Flags [.], ack 6, win 229, options [nop,nop,TS val 4596043 ecr 4596042], length 0
E..4..@.@............8.[.m.....x.... *.....
.F!K.F!J
```
observe the unencrypted packet payload captures.

note: the same verification can be performed against the client
container by changing the container id:

```$ docker exec -it --privileged mqtt_client_1 tcpdump -nl -A 'port 1883'```
