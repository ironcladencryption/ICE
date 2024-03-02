# UDP
This example demonstrates encrypting container traffic between a client
sending a udp packet to a server listening for udp traffic on port 50837

## Getting Started

```
$ git clone https://github.com/icemicro/icecube.git
$ cd icecube/examples/udp
$ ./build.sh
$ docker-compose up
```

That's it!  The trusted network is now encrypting udp traffic amongst
two containers.

The terminal will produce output similar to the following:  

```
Starting udp_client_1 ...
Starting udp_server_1 ...
Starting udp_server_1
Starting udp_server_1 ... done
Attaching to udp_client_1, udp_server_1
server_1  |
server_1  |     ____          ______      __
server_1  |    /  _/_______  / ____/_  __/ /_  ___
server_1  |    / // ___/ _ \/ /   / / / / __ \/ _ \
server_1  |  _/ // /__/  __/ /___/ /_/ / /_/ /  __/
server_1  | /___/\___/\___/\____/\__,_/_.___/\___/
server_1  |
server_1  | icecube version:    0.2.3-beta
server_1  | iceman version:     0.3.0
server_1  |
server_1  | crypto strategy:    fernet
server_1  | encryption enabled: True
server_1  |
server_1  |     role   | protocol | port
server_1  |     ______ | ________ | _____
server_1  |     server | udp      | 50837
server_1  |
client_1  |
client_1  |     ____          ______      __
client_1  |    /  _/_______  / ____/_  __/ /_  ___
client_1  |    / // ___/ _ \/ /   / / / / __ \/ _ \
client_1  |  _/ // /__/  __/ /___/ /_/ / /_/ /  __/
client_1  | /___/\___/\___/\____/\__,_/_.___/\___/
client_1  |
client_1  | icecube version:    0.2.3-beta
client_1  | iceman version:     0.3.0
client_1  |
client_1  | crypto strategy:    fernet
client_1  | encryption enabled: True
client_1  |
client_1  |     role   | protocol | port
client_1  |     ______ | ________ | _____
client_1  |     client | udp      | 50837
client_1  |
client_1  |
client_1  | ################ sleeping for 2 seconds ##################
client_1  |
server_1  | hello world
```

### Inspection
Run the following command to inspect container traffic:  

```$ docker exec -it udp_server_1 tcpdump -X -n port 50837```

The terminal will produce output similar to the following:  

```
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
11:14:02.211782 IP 172.20.0.2.56956 > 172.20.0.3.50837: UDP, length 12
        0x0000:  4500 0080 4e72 4000 4011 93cd ac14 0002 E...Nr@.@.......
        0x0010:  ac14 0003 de7c c695 0014 6497 6741 4141 .....|....d.gAAA
        0x0020:  4141 4261 4274 7436 5968 7576 466c 5450 AABaBtt6YhuvFlTP
        0x0030:  434e 556a 4b6d 7731 514e 5759 5f6e 4c43 CNUjKmw1QNWY_nLC
        0x0040:  3169 7467 5246 4947 3857 6536 4c72 794c 1itgRFIG8We6LryL
        0x0050:  4161 666e 4e69 6235 5970 6758 6e32 334e AafnNib5YpgXn23N
        0x0060:  6142 5552 3649 6757 2d56 336f 7568 6a41 aBUR6IgW-V3ouhjA
        0x0070:  595a 6845 3950 4d38 7961 5f6b 4f41 3d3d YZhE9PM8ya_kOA==
```
observe the encrypted packet payload  

### Verification
By default the containers encrypt network traffic.  To see what
network traffic looks like unencrypted, edit [base.env](base.env) and change
`ICEMAN_ENCRYPTION_ENABLED=False`.  __This is recommended for development
purposes only.__

Restart the network:  

```$ docker-compose down && docker-compose up```

Inspect the traffic:  

```$ docker exec -it udp_server_1 tcpdump -X -n port 50837```

The terminal will produce output similar to the following:  

```
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
11:32:43.146234 IP 172.20.0.3.57880 > 172.20.0.2.50837: UDP, length 12
        0x0000:  4500 0028 7f33 4000 4011 6364 ac14 0003 E..(.3@.@.cd....
        0x0010:  ac14 0002 e218 c695 0014 6d11 6865 6c6c ..........m.hell
        0x0020:  6f20 776f 726c 640a                      o.world.
```
observe the unencrypted packet payload

note: the same verification can be performed against the client
container by changing the container id:

```$ docker exec -it udp_client_1 tcpdump -X -n port 50837```
