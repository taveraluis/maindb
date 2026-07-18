# Pastry Database Stack

This project provides a shared PostgreSQL database environment for local services, along with Adminer for database administration.

## Prerequisites

Before starting the stack, populate the secret files in the [secret_files](secret_files) directory. Docker Compose expects these files to exist:

- [secret_files/pp_pwd](secret_files/pp_pwd)
- [secret_files/gogs_pwd](secret_files/gogs_pwd)
- [secret_files/forgejo_pwd](secret_files/forgejo_pwd)

Each file should contain the password for the corresponding database user, with no extra whitespace or trailing newline if possible.

Example:
```bash
mkdir -p secret_files
printf 'super-secret-password' > secret_files/pp_pwd
printf 'gogs-password' > secret_files/gogs_pwd
printf 'forgejo-password' > secret_files/forgejo_pwd
```

## Quick Start

### 1. Start the Services
```bash
docker compose down
docker container prune -f
docker volume prune -f
docker compose up -d -V
```

This starts:
- **PostgreSQL**: localhost:5432
- **Adminer**: http://localhost:8080

### 2. Access Adminer
Open: http://localhost:8080

Use the database credentials defined in the compose setup and the initialized database name as needed.

## Services

### PostgreSQL (psql)
- **Image**: postgres:18.4-alpine
- **Port**: 5432
- **Features**: initializes databases from [init_files](init_files)

### Adminer (adminer)
- **Image**: adminer
- **Port**: 8080
- **Purpose**: web-based database administration

## File Structure

```text
.
├── compose.yaml               # Docker Compose configuration
├── init_files/               # Database initialization scripts
├── misc_files/               # Additional configuration files
├── secret_files/             # Required Docker secrets (populate before start)
├── AGENTS.md                 # AI agent instructions
└── README.md                 # This file
```

## Common Tasks

### View Logs
```bash
docker compose logs psql
docker compose logs adminer
```

### Stop Services
```bash
docker compose stop
```

### Remove Everything
```bash
docker compose down -v
```

## Notes

- This repository provides the shared database infrastructure only.
- Any Git service integration that used to rely on Gogs-specific configuration has been moved outside of this project.
- For NFS mount permissions, make sure to allow the whole CIDR (just in case), do no mapping squash, check the boxes "Allow connections from non priviliged ports" and "allow users to access mounted subfolders", no not allow synchronous. Also make sure the shared mount (root location) has the "Everyone" access permission with full control.


## More Information

See [AGENTS.md](AGENTS.md) for project-specific notes and operational guidance.
