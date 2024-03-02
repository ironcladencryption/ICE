# Nginx
This example demonstrates encrypting container traffic between a client
requesting the root document from a vanilla nginx server

## Getting Started

```
$ git clone https://github.com/ironcladencryption/ice.git
$ cd ice/examples/nginx
$ ./build.sh
$ docker-compose up
```

That's it!  The trusted network is now encrypting tcp traffic amongst
the two containers.

The terminal will produce output similar to the following:  

```
Creating nginx_server_1 ...
Creating nginx_server_1 ... done
Creating nginx_client_1 ...
Creating nginx_client_1 ... done
Attaching to nginx_server_1, nginx_client_1
server_1  |
server_1  |     ____          ______      __
server_1  |    /  _/_______  / ____/_  __/ /_  ___
server_1  |    / // ___/ _ \/ /   / / / / __ \/ _ \
server_1  |  _/ // /__/  __/ /___/ /_/ / /_/ /  __/
server_1  | /___/\___/\___/\____/\__,_/_.___/\___/
server_1  |
server_1  | ice version:    0.2.3
server_1  | iceman version:     0.3.0
server_1  |
server_1  | crypto strategy:    fernet
server_1  | encryption enabled: True
server_1  |
server_1  |     role   | protocol | port
server_1  |     ______ | ________ | _____
server_1  |     server | tcp      | 8080
server_1  |
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
client_1  |     client | tcp      | 8080
client_1  |
client_1  |   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
client_1  |                                  Dload  Upload   Total   Spent    Left  Speed
100   612  100   612    0     0    193      0  0:00:03  0:00:03 --:--:--   193
client_1  | <!DOCTYPE html>
client_1  | <html>
client_1  | <head>
client_1  | <title>Welcome to nginx!</title>
client_1  | <style>
client_1  |     body {
client_1  |         width: 35em;
client_1  |         margin: 0 auto;
client_1  |         font-family: Tahoma, Verdana, Arial, sans-serif;
client_1  |     }
client_1  | </style>
client_1  | </head>
client_1  | <body>
client_1  | <h1>Welcome to nginx!</h1>
client_1  | <p>If you see this page, the nginx web server is successfully installed and
client_1  | working. Further configuration is required.</p>
client_1  |
client_1  | <p>For online documentation and support please refer to
client_1  | <a href="http://nginx.org/">nginx.org</a>.<br/>
client_1  | Commercial support is available at
client_1  | <a href="http://nginx.com/">nginx.com</a>.</p>
client_1  |
client_1  | <p><em>Thank you for using nginx.</em></p>
client_1  | </body>
client_1  | </html>
client_1  |
client_1  | ################ sleeping for 2 seconds ##################
```

### Inspection
Run the following command to inspect container traffic:  

```$ docker exec -it --privileged nginx_server_1 tcpdump -nl -A 'port 8080'```

The terminal will produce output similar to the following:  

```
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
09:36:16.123356 IP 172.18.0.3.46904 > 172.18.0.2.8080: Flags [S], seq 3011556517, win 29200, options [mss 1460,sackOK,TS val 4497590 ecr 0,nop,wscale 7], length 0
E..<..@.@............8............r............
.D..........
09:36:16.125836 IP 172.18.0.2.8080 > 172.18.0.3.46904: Flags [S.], seq 244005840, ack 3011556518, win 28960, options [mss 1460,sackOK,TS val 4497590 ecr 4497590,nop,wscale 7], length 0
E..<..@.@..............8..;.......q .e.........
.D...D......
09:36:16.127049 IP 172.18.0.3.46904 > 172.18.0.2.8080: Flags [.], ack 1, win 229, options [nop,nop,TS val 4497590 ecr 4497590], length 0
E..4..@.@............8........;.....Rm.....
.D...D..
09:36:16.130170 IP 172.18.0.3.46904 > 172.18.0.2.8080: Flags [P.], seq 1:185, ack 1, win 229, options [nop,nop,TS val 4497590 ecr 4497590], length 184: HTTP
E.....@.@............8........;............
.D...D..gAAAAABaCWeQJ8XOH6gOWhxEc6W2lTioB9u_gDTFtOeIYQ-W6kIQ0DJ--10Byzf55MbYoQvB0IYB4gf3XwZWyjdMXdYsPxzzVO2OPCS7jmdrhzILGwNGm_6u-Gx8i3cVAF8u_d7tIC8ISiRsUXIAP2gcJCALsZQbdzdRm1pzG-d8_vpCiyqBYVo=
09:36:16.133898 IP 172.18.0.2.8080 > 172.18.0.3.46904: Flags [.], ack 76, win 227, options [nop,nop,TS val 4497591 ecr 4497590], length 0
E..4.g@.@.G3...........8..;.........R#.....
.D...D..
09:36:16.136934 IP 172.18.0.2.8080 > 172.18.0.3.46904: Flags [P.], seq 1:421, ack 76, win 227, options [nop,nop,TS val 4497591 ecr 4497590], length 420: HTTP
E....h@.@.E............8..;.........N......
.D...D..gAAAAABaCWeQj-K5PiKf77HsuTCE846lZdHI9eG507C352KeIkTaT2J6Zb7bWM_29xG_FJe7Rxu7vaZ7x4244NEYxBxsLnVywB5y81UTlfNke7-rZcopGGvcVRbzjXO4T23wUeJd232iGHNJ41a90Np3Lsw1rXJNUyhFFCKIMAQ_gWrcJloRdjkcDrq44XmatmiThcYiQGRKhV4BSMFTY_JH1VhYh7WNeWvMek2iva_tUNqwFqqgXmBQePLsN8qKstiEqRhnYu--0H_dd8WkpuaH84Bb-zYRzwnDqxqt7IXPV-VizmiiT2tjm87WYrx_WK_Xnowezyd41w5X4fTn8G5-Zjbb89A_GY6sgpnLctKZNf1r5XMBSdnZAoLqCjoTmm2Mw2st8vh9aJAz2yNFmJYx8CwtkszZLw==
09:36:16.139946 IP 172.18.0.2.8080 > 172.18.0.3.46904: Flags [P.], seq 248:1156, ack 76, win 227, options [nop,nop,TS val 4497591 ecr 4497590], length 908: HTTP
E....i@.@.C............8..<..........r.....
.D...D..gAAAAABaCWeQ6mn_ZoRuf6JCz8jFMM1YGW5YDy2yCojTann-vIDZc99MZNV6gkiD38CnZItjoA4whNlraWNDQtCjEmIPgruWuRMNhoy9f1-93zdDsv5ti7JcyTamp9o1CxfOZlWdFNZ5Z02afDw9JvVjx82Z8qBKxIpMaP0iICt1SdbAHV3tMhL--nmzIEDlcPF_38QuHW0Kl2PIOoIzRqDwFAFhClMS3GBivvwFK_qT-nD6-4t29_MAFRvDiabt4lwZmmT9pCn1G64emRt1LUOQSdUKgFZz-LmbsrODXiXI4mQBnsEdTqUngJKeVC4ydzGtRL9xw-esgOSEZI7bbpzR82veuF_i6lVHHDk-AesviY78KwwYqVmoZH9udlCfhRaNjSxeKI73eB9hQLck2AdAYvQb4KSO8YjvETxu_ivRdS2lehmuNV0P0EC03vcwWD6xLXQImA8wJp-cuZzSSxzlyH26nSIFJoWvuNDB3SmJqe97uWupOwx3qJIlEywXDdrJSMcLxmvdtSThY84ScHW2y9fhPUQ1_tIW_Epq58Yp8_fz3MlNu4nnRdNpvS46Mot-6kNOjbqg-GPUtpENHtEtybnnymz1WkqBXuibUX4r3yvLGLdF7vG4aDKQPMDYle8bjkvuqy6LU7k8b7zEQg8HuBBC3_rR7Nx-FSsnfwWaje_B0tQZ3pyYEGuT7GicPOjpD6V7QZRSxswpAzpEgo6Bf7uAlBuYevpM9FMZtwXE3GZOjwggVN8v81ZlGyHZjkWdjeqBrRffRpYcN9MHs494MBb12JtW6_3E4_Hc-vL-SidiKx3fbc4WZ0SPMng-jkloPxingakTvCrpLmFqFA8FWu4fJKVZsnzSsIM8KUhxReRFZaaO4nYkl-2LwyZong2GoRU7TlpA
09:36:16.142150 IP 172.18.0.3.46904 > 172.18.0.2.8080: Flags [.], ack 248, win 237, options [nop,nop,TS val 4497592 ecr 4497591], length 0
E..4..@.@............8........<.....Q .....
.D...D..
09:36:16.145378 IP 172.18.0.3.46904 > 172.18.0.2.8080: Flags [.], ack 860, win 247, options [nop,nop,TS val 4497592 ecr 4497591], length 0
E..4..@.@............8........?,....N......
.D...D..
09:36:16.148047 IP 172.18.0.3.46904 > 172.18.0.2.8080: Flags [F.], seq 76, ack 860, win 247, options [nop,nop,TS val 4497592 ecr 4497591], length 0
E..4..@.@............8........?,....N......
.D...D..
09:36:16.149263 IP 172.18.0.2.8080 > 172.18.0.3.46904: Flags [F.], seq 860, ack 77, win 227, options [nop,nop,TS val 4497592 ecr 4497592], length 0
E..4.j@.@.G0...........8..?,........N......
.D...D..
09:36:16.150388 IP 172.18.0.3.46904 > 172.18.0.2.8080: Flags [.], ack 861, win 247, options [nop,nop,TS val 4497593 ecr 4497592], length 0
E..4..@.@............8........?-....N......
.D...D..
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

```$ docker exec -it --privileged nginx_server_1 tcpdump -nl -A 'port 8080'```

The terminal will produce output similar to the following:  

```
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
09:38:00.881678 IP 172.18.0.3.47200 > 172.18.0.2.8080: Flags [S], seq 1734106020, win 29200, options [mss 1460,sackOK,TS val 4508066 ecr 0,nop,wscale 7], length 0
E..<..@.@.P..........`..g\[.......r............
.D..........
09:38:00.883275 IP 172.18.0.2.8080 > 172.18.0.3.47200: Flags [S.], seq 2355574328, ack 1734106021, win 28960, options [mss 1460,sackOK,TS val 4508066 ecr 4508066,nop,wscale 7], length 0
E..<..@.@..............`.g68g\[...q .F.........
.D...D......
09:38:00.885076 IP 172.18.0.3.47200 > 172.18.0.2.8080: Flags [.], ack 1, win 229, options [nop,nop,TS val 4508066 ecr 4508066], length 0
E..4..@.@.P..........`..g\[..g69....,N.....
.D...D..
09:38:00.894563 IP 172.18.0.3.47200 > 172.18.0.2.8080: Flags [P.], seq 1:76, ack 1, win 229, options [nop,nop,TS val 4508066 ecr 4508066], length 75: HTTP: GET / HTTP/1.1
E.....@.@.PG.........`..g\[..g69.....Q.....
.D...D..GET / HTTP/1.1
Host: server:8080
User-Agent: curl/7.47.0
Accept: */*


09:38:00.898473 IP 172.18.0.2.8080 > 172.18.0.3.47200: Flags [.], ack 76, win 227, options [nop,nop,TS val 4508067 ecr 4508066], length 0
E..4..@.@..............`.g69g\[.....,......
.D...D..
09:38:00.901252 IP 172.18.0.2.8080 > 172.18.0.3.47200: Flags [P.], seq 1:248, ack 76, win 227, options [nop,nop,TS val 4508067 ecr 4508066], length 247: HTTP: HTTP/1.1 200 OK
E..+..@.@..............`.g69g\[.....T......
.D...D..HTTP/1.1 200 OK
Server: nginx/1.10.3 (Ubuntu)
Date: Mon, 13 Nov 2017 09:38:00 GMT
Content-Type: text/html
Content-Length: 612
Last-Modified: Tue, 31 Jan 2017 15:01:11 GMT
Connection: keep-alive
ETag: "5890a6b7-264"
Accept-Ranges: bytes


09:38:00.906322 IP 172.18.0.3.47200 > 172.18.0.2.8080: Flags [.], ack 248, win 237, options [nop,nop,TS val 4508068 ecr 4508067], length 0
E..4.   @.@.P..........`..g\[..g70....+......
.D...D..
09:38:00.908065 IP 172.18.0.2.8080 > 172.18.0.3.47200: Flags [P.], seq 248:860, ack 76, win 227, options [nop,nop,TS val 4508067 ecr 4508066], length 612: HTTP
E.....@.@..............`.g70g\[.....l......
.D...D..<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```
observe the unencrypted packet payload captures

note: the same verification can be performed against the client
container by changing the container id:

```$ docker exec -it --privileged nginx_client_1 tcpdump -nl -A 'port 8080'```
