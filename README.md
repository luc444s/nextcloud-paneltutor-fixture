# Nextcloud PanelTutor fixture

Real integration fixture for PanelTutor Apps using official images:

- Nextcloud 35 + Apache on port 8080
- MariaDB 11.4
- Redis 7.4
- Nextcloud cron sidecar
- Named persistent volumes only
- Numeric non-root users
- No published host ports or host bind mounts

## Compose file

Use `compose.yaml` and select `app:8080` as the ingress when required.

## Required environment

PanelTutor Apps automatically generates and injects the stable encrypted
database credentials `APP_DB_NAME`, `APP_DB_USER`, and `APP_DB_PASSWORD`.
The fixture maps them to both MariaDB and Nextcloud; do not supply them.

Configure only these values in PanelTutor Apps; never commit them:

- `NEXTCLOUD_ADMIN_USER`
- `NEXTCLOUD_ADMIN_PASSWORD`
- `NEXTCLOUD_TRUSTED_DOMAINS`
- `OVERWRITEHOST`

Optional values:

- `OVERWRITEPROTOCOL` (default `https`)

## Acceptance checks

1. All four services become running; db, redis, and app become healthy.
2. The Nextcloud login page responds through the managed Apps route.
3. Create a file, redeploy, and verify that it remains available.
4. Verify the MariaDB, Redis, and Nextcloud named volumes survive redeploy.
5. Verify every container is non-root and uses a read-only root filesystem.
