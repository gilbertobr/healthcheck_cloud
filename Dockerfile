FROM ubuntu:22.10
ENV LANG=en_US.UTF-8
ENV PORT=4000 MIX_ENV=prod

USER root:root
WORKDIR /app
COPY ./_build /app/_build
RUN apt-get update -y
RUN apt-get install -y libssl-dev libcurl4-openssl-dev wget gnupg2 inotify-tools locales elixir && \
  locale-gen en_US.UTF-8 && \
  apt-get clean all

RUN wget http://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb && \
dpkg -i libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb && rm -f libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb

EXPOSE 4000

CMD ["/app/_build/prod/rel/healthcheck_cloud/bin/healthcheck_cloud", "start"]
