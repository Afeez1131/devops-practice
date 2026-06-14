#!/bin/bash
set -e

echo "==> Installing PostgreSQL..."
apt-get update -y
apt-get install -y postgresql postgresql-contrib

echo "==> Detecting PostgreSQL version..."
PG_VERSION=$(psql --version | awk '{print $3}' | cut -d. -f1)
PG_HBA=/etc/postgresql/${PG_VERSION}/main/pg_hba.conf
PG_CONF=/etc/postgresql/${PG_VERSION}/main/postgresql.conf

echo "==> Enabling remote connections..."
echo "host    all    all    192.168.56.0/24    scram-sha-256" >> $PG_HBA
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" $PG_CONF

echo "==> Starting PostgreSQL..."
systemctl enable postgresql
systemctl restart postgresql

echo "==> Creating DB user and database..."
sudo -u postgres psql <<SQL
-- DO block makes user creation idempotent: CREATE USER has no IF NOT EXISTS before PG 9.x,
-- and even on newer versions EXECUTE format() lets us safely interpolate the password
DO \$\$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = '${DB_USER}') THEN
        EXECUTE format('CREATE USER %I WITH PASSWORD %L', '${DB_USER}', '${DB_PASS}');
    END IF;
END
\$\$;

-- \gexec executes the string returned by SELECT as a SQL command —
-- the WHERE NOT EXISTS makes database creation idempotent too
SELECT format('CREATE DATABASE %I OWNER %I', '${DB_NAME}', '${DB_USER}')
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '${DB_NAME}')
\gexec

GRANT ALL PRIVILEGES ON DATABASE ${DB_NAME} TO ${DB_USER};
SQL

echo "==> Done. PostgreSQL is ready."