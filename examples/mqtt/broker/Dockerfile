FROM icemicro/ice:latest

RUN apt-get install -y mosquitto

RUN mkdir -p /mqtt/config /mqtt/data /mqtt/log
COPY config /mqtt/config
RUN chown -R mosquitto:mosquitto /mqtt
VOLUME ["/mqtt/config", "/mqtt/data", "/mqtt/log"]

ADD entrypoint.sh entrypoint.sh
CMD ["bash", "entrypoint.sh"]
