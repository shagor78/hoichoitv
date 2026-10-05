#!/bin/bash
BACKUP_DIR="./backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
mkdir -p $BACKUP_DIR

echo "Backing up MySQL database..."
docker exec hoichoi-mysql mysqldump -u root -ppassword hoichoi_iptv | gzip > "$BACKUP_DIR/hoichoi_iptv_$TIMESTAMP.sql.gz"

echo "Cleaning old backups (keeping last 7)..."
ls -t $BACKUP_DIR/hoichoi_iptv_*.sql.gz | tail -n +8 | xargs -r rm

echo "Backup complete: $BACKUP_DIR/hoichoi_iptv_$TIMESTAMP.sql.gz"
