# Ironclad Container Encryption
A solution for authenticating and encrypting traffic amongst interconnected
and distributed Docker services. By setting a few environment variables,
ICE can be used to secure services across disparate container
scheduling and orchestration platforms.  Containers help the community build,
ship, and run distributed applications.  ICE aims to abstract container
(Docker) services' intercommunication into a Trust plane by providing the
following:

1. Docker-compatible service abstraction - Docker Swarm, Kubernetes,
  Mesos, Docker native
2. Easy to configure and install container
3. Orthogonality - your service doesn't have to be modified to communicate
   securely with its network!

## Overview

![ice-level-0](img/ice-level-0.svg "ICE Architecture")

ICE abstracts docker services into a Trustplane.  This is
accomplished by the following:

  - The ICE container intercepts layer 4 egress and
    ingress traffic given a transport-layer protocol (e.g., TCP, UDP)
    and a transport-layer port (0-65535).
  - Given a preshared key, ICE encrypts and decrypts egress and ingress
    layer 4 traffic (respectfully) using configurable symmetric encryption
    TLS cipher suites.

    <!--TODO-->
  - For egress traffic, the service's layer 4 egress payload is encrypted
    before being routed to its destination external to the container
  - For ingress traffic, the service's layer 4 ingress payload is
    decrypted before being routed to the service running within the docker
    container

## Features

- orthogonal to your docker service - changing your service does not
  affect the ICE container's ability to secure its inbound and outbound traffic!
- easy to configure, use, and extend
- TLS using AES symmetric encryption cipher suites

## Infrastructure Configurations
Ironclad Container Encryption (ICE) trusted networks were designed to run in
IaaS platforms (Amazon Web Services, Google Compute Engine, Azure,
etc.).  ICE trusted networks also traverse distinct Docker Management
solutions such as Kubernetes, Elastic Container Service, Mesos, and Docker
Swarm.  Moreover, given that ICE symmetric TLS traffic is terminated
within the container itself, it is even possible to encrypt ICE
trusted network traffic across multiple IaaS platforms running different
Docker Clusters!

In general, any publicly addressable ICE containerized services are
capable of encrypting traffic.  This approach lends itself to various
combinations of cloud provider / container platform.

Furthermore, because the ICE solution is docker-compatible,
integrating with existing Colo / legacy data centers is as
straightforward as instantiating ICE containers in a
docker-compatible hypervisor.

Example configurations are outlined below.

## Single IaaS Platform / Single Docker Management Platform

### Amazon Web Services <=> Kubernetes
![single-iaas-level-1](img/single-iaas-level-1.svg "Hybrid")

## Multiple IaaS Platforms

### Google Compute Engine (Kubernetes) <=> Amazon Web Services (ECS)
![multiple-iaas-level-1](img/multiple-iaas-level-1.svg "Hybrid")

## Hybrid

### Colo (Hypervisor) <=> Amazon Web Services (Kubernetes)
![hybrid-level-1](img/hybrid-level-1.svg "Hybrid")

## Requirements and Assumptions

- The service is installed and setup to run within an ICE container
  see [Examples](#examples)
- ICE docker services must be instantiated with `cap_add=NET_ADMIN`.
  Because iptable rules are configured at runtime, the container must be
  able to modify its network interfaces.
- Members of each Trustplane must be configured to use the same
  preshared_key and crypto strategy
- Common long-term support (LTS) Linux distributions are supported.

## Getting Started

```
$ docker run \
  --cap-add=NET_ADMIN \
  -e "ICE_ROLES=server:tcp:9001" \
  -e "ICE_CRYPTO_STRATEGY=fernet" \
  -e "ICE_ENCRYPTION_ENABLED=True" \
  -e "ICE_PRESHARED_KEY=supersecret123" \
  -it ironcladencryption/ice
```

The terminal will produce output simliar to the following:  

```
    ____          ______      __
   /  _/_______  / ____/_  __/ /_  ___
   / // ___/ _ \/ /   / / / / __ \/ _ \
 _/ // /__/  __/ /___/ /_/ / /_/ /  __/
/___/\___/\___/\____/\__,_/_.___/\___/

ice version:    0.2.3

crypto strategy:    fernet
encryption enabled: True

        role   | protocol | port
        ______ | ________ | _____
        server | tcp      | 9001
```

The ICE container is now running...  

See [Examples](#examples) for a list of
more pragmatic approaches to using ICE containers.

## Installation

Prerequisites:

  - Install Docker [https://docs.docker.com/engine/installation/](https://docs.docker.com/engine/installation/)

Configuration:

| environment_variable | required | choices | comments |
|:-------------------- |:-------------------- |:-------------------- |:--------------------|
| ICE_ROLES | yes | (client/server):(tcp/udp):(0-65535) | the ICEservice roles.  E.g., _server:tcp:9001_ or _client:tcp:8080,server:udp:50877_ |
| ICE_CRYPTO\_STRATEGY | yes | fernet, ice | the ICE cipher suite crypto strategy |
| ICE_ENCRYPTION\_ENABLED | yes | True, False | for development, this controls whether the ICE container encrypts/decrypts layer 4 payloads |
| ICE_PRESHARED\_KEY | yes | | the preshared secret key used to encrypt ICE inter-container traffic |

Running it:

```
$ docker run \
  --cap-add=NET_ADMIN \
  -e "ICE_ROLES=server:tcp:9001" \
  -e "ICE_CRYPTO_STRATEGY=fernet" \
  -e "ICE_ENCRYPTION_ENABLED=True" \
  -e "ICE_PRESHARED_KEY=supersecret123" \
  -it ironcladencryption/ice
```

Docker Hub:

ICE images are available on Docker Hub:
<!--TODO-->
[https://hub.docker.com/r/icemicro/ice/](https://hub.docker.com/r/icemicro/ice/)

## Examples

### 1. mqtt client/broker
<!--TODO-->
[mqtt
client/broker](https://github.com/ironcladencryption/ice/blob/master/examples/mqtt/)

An ICE trusted network consisting of two services:

1. a [mosquitto](https://mosquitto.org/) mqtt broker
2. a [mosquitto](https://mosquitto.org/) client subscribing to the `test/topic`
   topic and publishing to the `test/topic`

### 2. nginx client/server
<!--TODO-->
[nginx
client/server](https://github.com/ironcladencryption/ice/blob/master/examples/nginx/)

An ICE trusted network consisting of two services:

1. a vanilla nginx server
2. client (cURL) - requests the root doc `/` every 2 seconds

### 3. udp client/server
<!--TODO-->
[udp
client/server](https://github.com/ironcladencryption/ice/blob/master/examples/udp/)

An ICE trusted network consisting of two services:

1. a server ([socat](http://www.dest-unreach.org/socat/doc/socat.html)) - listens for UDP traffic on a given port
2. a client ([socat](http://www.dest-unreach.org/socat/doc/socat.html)) - sends a UDP message to the server every 2 seconds

### 4. non-encrypted server proxying (Icetunnel)
<!--TODO-->
[tunnel](https://github.com/ironcladencryption/ice/blob/master/examples/tunnel/)

An ICE trusted network consisting of three services:

1. a server ([socat](http://www.dest-unreach.org/socat/doc/socat.html)) - listens for TCP traffic on a given port
2. a proxy ([haproxy](http://www.haproxy.org/)) - set to proxy traffic to the server
3. a client ([socat](http://www.dest-unreach.org/socat/doc/socat.html)) - sends a TCP message to the proxy every 2 seconds
