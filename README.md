# PgCat - High Performance PostgreSQL Connection Pooler

Modern Rust-based connection pooler for SMSLY Platform with SCRAM-SHA-256 support.

## Features

- **Transaction pooling**: Efficient connection reuse
- **SCRAM-SHA-256**: Native support for modern PostgreSQL authentication
- **High performance**: Rust-based, low latency
- **Per-database pools**: Separate pools for each service database

## Deployment in Coolify

### 1. Create New Service

1. Go to Coolify → Projects → SMSLYCLOUD → Add Resource
2. Choose **Docker Compose** or **Dockerfile**
3. Set repository: Your monorepo URL
4. Set Base Directory: `/pgcat`
5. Set Dockerfile Location: `Dockerfile`

### 2. Configure Network

Ensure PgCat is on the same network as:

- `postgres` (the database)
- All services that need database access

### 3. Environment Variables

No environment variables needed - all config is in `pgcat.toml`.

### 4. Service URLs

Update your services to connect via PgCat:

| Service | DATABASE_URL |
|---------|--------------|
| smsly-backend | `postgresql://postgres:PASSWORD@pgcat:5432/smsly_backend` |
| smsly-audit-log-service | `postgresql+asyncpg://postgres:PASSWORD@pgcat:5432/smsly_audit` |
| smsly-transaction-chain | `postgresql+asyncpg://postgres:PASSWORD@pgcat:5432/smsly_txchain` |
| smsly-identity-service | `postgresql+asyncpg://postgres:PASSWORD@pgcat:5432/smsly_identity` |
| smsly-platform-api | `postgresql+asyncpg://postgres:PASSWORD@pgcat:5432/smsly_platform` |
| smsly-policy-service | `postgresql+asyncpg://postgres:PASSWORD@pgcat:5432/smsly_policy` |

## Configuration

The `pgcat.toml` file contains:

- **Pool settings**: transaction mode, pool sizes
- **User credentials**: postgres user with password
- **Database pools**: One pool per service database
- **Performance tuning**: Worker threads, timeouts

### Pool Sizes

| Database | Pool Size | Purpose |
|----------|-----------|---------|
| smsly_backend | 50 | Main Django backend |
| smsly_platform | 40 | Platform API |
| smsly_txchain | 30 | Transaction chain |
| smsly_identity | 30 | Identity service |
| smsly_audit | 20 | Audit logging |
| smsly_policy | 20 | Policy service |

## Monitoring

PgCat exposes admin stats on the same port. Connect with:

```bash
psql -h pgcat -p 5432 -U admin -d pgcat
```

Commands:

- `SHOW POOLS;` - Pool statistics
- `SHOW CLIENTS;` - Client connections
- `SHOW SERVERS;` - Server connections
- `SHOW STATS;` - Overall statistics

## Security Notes

⚠️ **Before production:**

1. Change `admin_password` in `pgcat.toml`
2. Ensure password matches actual Postgres password
3. Consider enabling TLS for client connections
