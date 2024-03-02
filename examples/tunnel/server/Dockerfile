FROM ubuntu:16.04

RUN apt-get update && apt-get install -y socat

ADD entrypoint.sh entrypoint.sh
CMD ["bash", "entrypoint.sh"]
