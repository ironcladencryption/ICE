FROM icemicro/ice:latest

RUN apt-get update --fix-missing
RUN apt-get install -y curl

ADD entrypoint.sh entrypoint.sh
CMD ["bash", "entrypoint.sh"]
