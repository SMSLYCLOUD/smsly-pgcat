FROM ghcr.io/postgresml/pgcat:main

COPY pgcat.toml /etc/pgcat/pgcat.toml

EXPOSE 5432

CMD ["pgcat", "/etc/pgcat/pgcat.toml"]
