FROM icemicro/ice:latest

RUN apt-get install -y haproxy
COPY haproxy.cfg /etc/haproxy/haproxy.cfg

ADD entrypoint.sh entrypoint.sh
CMD ["bash", "entrypoint.sh"]
