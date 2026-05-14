# Telco Project Setup Steps

This guide explains how to reproduce the Oracle XE setup, load the CSV files, and run the SQL answers for this project. The Docker Compose setup uses the [`gvenzl/oracle-xe:21-slim-faststart`](https://github.com/gvenzl/oci-oracle-xe) image and initializes the `TELCO` schema automatically on first startup.

## 1. Requirements

Install these tools before running the project:

- Docker Desktop
- DBeaver

Verify Docker from the project folder:

```powershell
docker --version
docker compose version
```

## 2. Start Oracle XE

Run this command in the repository root:

```powershell
docker compose up -d
```

Check the logs until the database reports that it is ready:

```powershell
docker logs -f telco-oracle
```

The container exposes Oracle on `localhost:1521`.

## 3. Database Connection Details

Use these values for SQL*Plus or DBeaver:

| Field | Value |
| --- | --- |
| Host | `localhost` |
| Port | `1521` |
| Service name | `XEPDB1` |
| Username | `TELCO` |
| Password | `Telco12345` |
| JDBC URL | `jdbc:oracle:thin:@//localhost:1521/XEPDB1` |

The SYS/SYSTEM password configured for the container is `Oracle12345`.

## 4. Automatic Table Creation

On the first container startup, Docker runs:

```text
docker/init/001_init_telco.sql
```

That script creates the `TELCO` user and runs:

```text
TABLE_CREATION_SCRIPTS.sql
```

The table script creates the `TARIFFS`, `CUSTOMERS`, and `MONTHLY_STATS` tables with their constraints and indexes.

## 5. Load CSV Data

After Oracle is ready, import the CSV files:

```powershell
docker exec -it telco-oracle bash /workspace/loader/load-data.sh
```

Expected row counts:

| Table | Row count |
| --- | ---: |
| `TARIFFS` | 4 |
| `CUSTOMERS` | 10000 |
| `MONTHLY_STATS` | 9950 |

## 6. Connect with DBeaver

Create a new Oracle connection in DBeaver using the connection values above. Select `Service Name` and enter `XEPDB1` as the database/service value. If DBeaver asks to download the Oracle JDBC driver, allow the download.

## 7. Run the Queries

Open `SOLUTIONS.sql` in DBeaver while connected as the `TELCO` user. Run each query section and compare the outputs with `QUERY_RESULTS.md`.

## 8. Screenshots

The repository includes screenshots under:

```text
docs/screenshots/
```

They show the Docker container, DBeaver connection, table counts, and query results.

## 9. Stop the Container

When finished, stop the database container:

```powershell
docker compose down
```

To remove the database volume and start from a completely clean database later:

```powershell
docker compose down -v
```
