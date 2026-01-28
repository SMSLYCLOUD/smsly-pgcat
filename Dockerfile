FROM ghcr.io/postgresml/pgcat:main

COPY pgcat.toml /etc/pgcat/pgcat.toml

# Install netcat for healthcheck
RUN apt-get update && apt-get install -y netcat-openbsd && rm -rf /var/lib/apt/lists/*

HEALTHCHECK --interval=10s --timeout=5s --start-period=5s --retries=3 \
    CMD nc -z localhost 5432 || exit 1

EXPOSE 5432

CMD ["pgcat", "/etc/pgcat/pgcat.toml"]
