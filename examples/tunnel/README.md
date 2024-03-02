# Tunnel
This example demonstrates a three node network containing three services:
A client, a server, and a proxy forwarding traffic to the server.  The
three containers will be instantiated using docker-compose.  Using
socat, the client will connect to the proxy container.  Using haproxy, the proxy
container will then forward the unencrypted traffic to the server.  The
server will then send the unencrypted response back to the proxy server
and the proxy server will send encrypted traffic back to the client.
This example is significant when migrating services from a legacy
environment such as a colo to a container-focused environment such as
Amazon Web Services.  

Reference:
[https://github.com/ironcladencryption/ice/tree/master/configurations#hybrid](https://github.com/ironcladencryption/ice/tree/master/configurations#hybrid)
for a visualization of this scenario.

## Getting Started

```
$ git clone https://github.com/ironcladencryption/ice.git
$ cd icecube/examples/tunnel
$ ./build.sh
$ docker-compose up
```


The terminal will produce output similar to the following:  

```
Creating tunnel_server_1 ...
Creating tunnel_server_1 ... done
Creating tunnel_proxy_1 ...
Creating tunnel_proxy_1 ... done
Creating tunnel_client_1 ...
Creating tunnel_client_1 ... done
Attaching to tunnel_server_1, tunnel_proxy_1, tunnel_client_1
proxy_1   |
proxy_1   |     ____          ______      __
proxy_1   |    /  _/_______  / ____/_  __/ /_  ___
proxy_1   |    / // ___/ _ \/ /   / / / / __ \/ _ \
proxy_1   |  _/ // /__/  __/ /___/ /_/ / /_/ /  __/
proxy_1   | /___/\___/\___/\____/\__,_/_.___/\___/
proxy_1   |
proxy_1   | ice version:    0.2.3
proxy_1   | iceman version:     0.3.0
proxy_1   |
proxy_1   | crypto strategy:    fernet
proxy_1   | encryption enabled: True
proxy_1   |
proxy_1   |     role   | protocol | port
proxy_1   |     ______ | ________ | _____
proxy_1   |     server | tcp      | 5555
proxy_1   |
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
client_1  |     client | tcp      | 5555
client_1  |
server_1  | hello world
client_1  |
client_1  | ################ sleeping for 2 seconds ##################
```

### Inspection
Run the following command to inspect container traffic:  

```$ docker exec -it tunnel_proxy_1 tcpdump -X -n port 5555```

The terminal will produce output similar to the following:  

```
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
09:07:17.732069 IP 172.21.0.4.46096 > 172.21.0.3.5555: Flags [S], seq 3612530829, win 29200, options [mss 1460,sackOK,TS val 4323751 ecr 0,nop,wscale 7], length 0
        0x0000:  4500 003c 212a 4000 4006 c160 ac15 0004  E..<!*@.@..`....
        0x0010:  ac15 0003 b410 15b3 d752 d88d 0000 0000  .........R......
        0x0020:  a002 7210 0a31 0000 0204 05b4 0402 080a  ..r..1..........
        0x0030:  0041 f9a7 0000 0000 0103 0307            .A..........
09:07:17.734538 IP 172.21.0.3.5555 > 172.21.0.4.46096: Flags [S.], seq 2308416239, ack 3612530830, win 28960, options [mss 1460,sackOK,TS val 4323751 ecr 4323751,nop,wscale 7], length 0
        0x0000:  4500 003c 0000 4000 4006 e28a ac15 0003  E..<..@.@.......
        0x0010:  ac15 0004 15b3 b410 8997 a2ef d752 d88e  .............R..
        0x0020:  a012 7120 e49f 0000 0204 05b4 0402 080a  ..q.............
        0x0030:  0041 f9a7 0041 f9a7 0103 0307            .A...A......
09:07:17.739177 IP 172.21.0.4.46096 > 172.21.0.3.5555: Flags [.], ack 1, win 229, options [nop,nop,TS val 4323751 ecr 4323751], length 0
        0x0000:  4500 0034 212b 4000 4006 c167 ac15 0004  E..4!+@.@..g....
        0x0010:  ac15 0003 b410 15b3 d752 d88e 8997 a2f0  .........R......
        0x0020:  8010 00e5 83a7 0000 0101 080a 0041 f9a7  .............A..
        0x0030:  0041 f9a7                                .A..
09:07:17.746663 IP 172.21.0.4.46096 > 172.21.0.3.5555: Flags [P.], seq 1:101, ack 1, win 229, options [nop,nop,TS val 4323751 ecr 4323751], length 100
        0x0000:  4500 0098 212c 4000 4006 c102 ac15 0004  E...!,@.@.......
        0x0010:  ac15 0003 b410 15b3 d752 d88e 8997 a2f0  .........R......
        0x0020:  8018 00e5 1b69 0000 0101 080a 0041 f9a7  .....i.......A..
        0x0030:  0041 f9a7 6741 4141 4141 4261 4357 4446  .A..gAAAAABaCWDF
        0x0040:  626a 5976 4542 7652 5975 6264 426a 2d70  bjYvEBvRYubdBj-p
        0x0050:  5954 7865 314a 7577 436d 5350 744e 696c  YTxe1JuwCmSPtNil
        0x0060:  6773 4e41 6270 4f50 3154 7861 4178 766d  gsNAbpOP1TxaAxvm
        0x0070:  4257 6869 7572 4762 676f 7556 3843 3766  BWhiurGbgouV8C7f
        0x0080:  414c 6e69 6744 4477 5533 5063 3730 7746  ALnigDDwU3Pc70wF
        0x0090:  4e63 346c 3751 3d3d                      Nc4l7Q==
09:07:17.747690 IP 172.21.0.4.46096 > 172.21.0.3.5555: Flags [F.], seq 13, ack 1, win 229, options [nop,nop,TS val 4323751 ecr 4323751], length 0
        0x0000:  4500 0034 212d 4000 4006 c165 ac15 0004  E..4!-@.@..e....
        0x0010:  ac15 0003 b410 15b3 d752 d89a 8997 a2f0  .........R......
        0x0020:  8011 00e5 839a 0000 0101 080a 0041 f9a7  .............A..
        0x0030:  0041 f9a7                                .A..
09:07:17.750130 IP 172.21.0.3.5555 > 172.21.0.4.46096: Flags [.], ack 13, win 227, options [nop,nop,TS val 4323752 ecr 4323751], length 0
        0x0000:  4500 0034 5b58 4000 4006 873a ac15 0003  E..4[X@.@..:....
        0x0010:  ac15 0004 15b3 b410 8997 a2f0 d752 d89a  .............R..
        0x0020:  8010 00e3 839c 0000 0101 080a 0041 f9a8  .............A..
        0x0030:  0041 f9a7                                .A..
09:07:17.753210 IP 172.21.0.3.5555 > 172.21.0.4.46096: Flags [F.], seq 1, ack 14, win 227, options [nop,nop,TS val 4323753 ecr 4323751], length 0
        0x0000:  4500 0034 5b59 4000 4006 8739 ac15 0003  E..4[Y@.@..9....
        0x0010:  ac15 0004 15b3 b410 8997 a2f0 d752 d89b  .............R..
        0x0020:  8011 00e3 8399 0000 0101 080a 0041 f9a9  .............A..
        0x0030:  0041 f9a7                                .A..
09:07:17.755963 IP 172.21.0.4.46096 > 172.21.0.3.5555: Flags [.], ack 2, win 229, options [nop,nop,TS val 4323753 ecr 4323753], length 0
        0x0000:  4500 0034 212e 4000 4006 c164 ac15 0004  E..4!.@.@..d....
        0x0010:  ac15 0003 b410 15b3 d752 d89b 8997 a2f1  .........R......
        0x0020:  8010 00e5 8395 0000 0101 080a 0041 f9a9  .............A..
        0x0030:  0041 f9a9
```
observe the encrypted packet payload in the 4th capture

### Verification
By default the containers encrypt network traffic.  To see what
network traffic looks like unencrypted, edit [base.env](base.env) and change
`ICE_ENCRYPTION_ENABLED=False`.  __This is recommended for development
purposes only.__

Restart the network:  

```$ docker-compose down && docker-compose up```

Inspect the traffic:  

```$ docker exec -it tunnel_proxy_1 tcpdump -X -n port 5555```

The terminal will produce output similar to the following:  

```
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
09:09:40.647166 IP 172.21.0.4.46360 > 172.21.0.3.5555: Flags [S], seq 609279908, win 29200, options [mss 1460,sackOK,TS val 4338042 ecr 0,nop,wscale 7], length 0
        0x0000:  4500 003c eede 4000 4006 f3ab ac15 0004  E..<..@.@.......
        0x0010:  ac15 0003 b518 15b3 2450 dfa4 0000 0000  ........$P......
        0x0020:  a002 7210 7d41 0000 0204 05b4 0402 080a  ..r.}A..........
        0x0030:  0042 317a 0000 0000 0103 0307            .B1z........
09:09:40.648683 IP 172.21.0.3.5555 > 172.21.0.4.46360: Flags [S.], seq 3171589857, ack 609279909, win 28960, options [mss 1460,sackOK,TS val 4338042 ecr 4338042,nop,wscale 7], length 0
        0x0000:  4500 003c 0000 4000 4006 e28a ac15 0003  E..<..@.@.......
        0x0010:  ac15 0004 15b3 b518 bd0a 9ee1 2450 dfa5  ............$P..
        0x0020:  a012 7120 f077 0000 0204 05b4 0402 080a  ..q..w..........
        0x0030:  0042 317a 0042 317a 0103 0307            .B1z.B1z....
09:09:40.650882 IP 172.21.0.4.46360 > 172.21.0.3.5555: Flags [.], ack 1, win 229, options [nop,nop,TS val 4338043 ecr 4338042], length 0
        0x0000:  4500 0034 eedf 4000 4006 f3b2 ac15 0004  E..4..@.@.......
        0x0010:  ac15 0003 b518 15b3 2450 dfa5 bd0a 9ee2  ........$P......
        0x0020:  8010 00e5 8f7e 0000 0101 080a 0042 317b  .....~.......B1{
        0x0030:  0042 317a                                .B1z
09:09:40.654318 IP 172.21.0.4.46360 > 172.21.0.3.5555: Flags [P.], seq 1:13, ack 1, win 229, options [nop,nop,TS val 4338043 ecr 4338042], length 12
        0x0000:  4500 0040 eee0 4000 4006 f3a5 ac15 0004  E..@..@.@.......
        0x0010:  ac15 0003 b518 15b3 2450 dfa5 bd0a 9ee2  ........$P......
        0x0020:  8018 00e5 fd91 0000 0101 080a 0042 317b  .............B1{
        0x0030:  0042 317a 6865 6c6c 6f20 776f 726c 640a  .B1zhello.world.
09:09:40.654865 IP 172.21.0.4.46360 > 172.21.0.3.5555: Flags [F.], seq 13, ack 1, win 229, options [nop,nop,TS val 4338043 ecr 4338042], length 0
        0x0000:  4500 0034 eee1 4000 4006 f3b0 ac15 0004  E..4..@.@.......
        0x0010:  ac15 0003 b518 15b3 2450 dfb1 bd0a 9ee2  ........$P......
        0x0020:  8011 00e5 8f71 0000 0101 080a 0042 317b  .....q.......B1{
        0x0030:  0042 317a                                .B1z
09:09:40.660854 IP 172.21.0.3.5555 > 172.21.0.4.46360: Flags [.], ack 13, win 227, options [nop,nop,TS val 4338044 ecr 4338043], length 0
        0x0000:  4500 0034 af99 4000 4006 32f9 ac15 0003  E..4..@.@.2.....
        0x0010:  ac15 0004 15b3 b518 bd0a 9ee2 2450 dfb1  ............$P..
        0x0020:  8010 00e3 8f72 0000 0101 080a 0042 317c  .....r.......B1|
        0x0030:  0042 317b                                .B1{
09:09:40.662745 IP 172.21.0.3.5555 > 172.21.0.4.46360: Flags [F.], seq 1, ack 14, win 227, options [nop,nop,TS val 4338044 ecr 4338043], length 0
        0x0000:  4500 0034 af9a 4000 4006 32f8 ac15 0003  E..4..@.@.2.....
        0x0010:  ac15 0004 15b3 b518 bd0a 9ee2 2450 dfb2  ............$P..
        0x0020:  8011 00e3 8f70 0000 0101 080a 0042 317c  .....p.......B1|
        0x0030:  0042 317b                                .B1{
09:09:40.664324 IP 172.21.0.4.46360 > 172.21.0.3.5555: Flags [.], ack 2, win 229, options [nop,nop,TS val 4338044 ecr 4338044], length 0
        0x0000:  4500 0034 eee2 4000 4006 f3af ac15 0004  E..4..@.@.......
        0x0010:  ac15 0003 b518 15b3 2450 dfb2 bd0a 9ee3  ........$P......
        0x0020:  8010 00e5 8f6d 0000 0101 080a 0042 317c  .....m.......B1|
        0x0030:  0042 317c
```
observe the unencrypted packet payload in the 4th capture

note: the same verification can be performed against the client
container by changing the container id:

```$ docker exec -it tunnel_client_1 tcpdump -X -n port 5555```
