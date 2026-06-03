FROM python:3.12-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends gettext-base \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir emailproxy prompt_toolkit

COPY entrypoint.sh /entrypoint.sh
COPY emailproxy.config.template /emailproxy.config.template

RUN chmod +x /entrypoint.sh

EXPOSE 1143 1025

VOLUME /config

CMD ["/entrypoint.sh"]
