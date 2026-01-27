FROM ghcr.io/postgresml/pgcat:latest

# Copy configuration
COPY pgcat.toml /etc/pgcat/pgcat.toml

# Expose PgCat port
EXPOSE 5432

# Health check
HEALTHCHECK --interval=10s --timeout=5s --start-period=5s --retries=3 \
    CMD pg_isready -h localhost -p 5432 || exit 1

# Run PgCat
CMD ["pgcat", "/etc/pgcat/pgcat.toml"]
