# Configurations
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
![single-iaas-level-1](../img/single-iaas-level-1.svg "Hybrid")

## Multiple IaaS Platforms

### Google Compute Engine (Kubernetes) <=> Amazon Web Services (ECS)
![multiple-iaas-level-1](../img/multiple-iaas-level-1.svg "Hybrid")

## Hybrid

### Colo (Hypervisor) <=> Amazon Web Services (Kubernetes)
![hybrid-level-1](../img/hybrid-level-1.svg "Hybrid")
