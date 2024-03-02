FROM icemicro/ice:latest

RUN apt-get install -y nginx

COPY nginx.conf /nginx.conf

ADD entrypoint.sh entrypoint.sh
CMD ["bash", "entrypoint.sh"]
