# SMSLY PgCat Connection Pooler

High-performance PostgreSQL connection pooler for the SMSLY platform.

## Features

- Transaction-level connection pooling
- Multi-database routing
- SCRAM-SHA-256 authentication support
- Auto-reload configuration

## Databases

- `smsly_backend` - Main Django backend
- `smsly_audit` - Audit logging service
- `smsly_txchain` - Transaction chain service
- `smsly_identity` - Identity service
- `smsly_platform` - Platform API
- `smsly_policy` - Policy service
- `smsly_gateway` - Security gateway

## Build

```bash
docker build -t smsly-pgcat .
```

## Run

```bash
docker run -d --name smsly-pgcat -p 5432:5432 smsly-pgcat
```
