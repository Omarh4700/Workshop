#!/bin/bash
# Script to encrypt db_backup.sql

set -e
# variables
DB_FILE="db_backup.sql"
ENCRYPTED_FILE="db_backup.sql.enc"
ENCRYPTION_KEY_FILE=".db_encryption_key"

# Check if db_backup.sql exists
if [ ! -f "$DB_FILE" ]; then
    echo "Error: $DB_FILE not found!"
    exit 1
fi

# Generate encryption key if it doesn't exist
if [ ! -f "$ENCRYPTION_KEY_FILE" ]; then
    openssl rand -base64 32 > "$ENCRYPTION_KEY_FILE"
    echo "Encryption key generated: $ENCRYPTION_KEY_FILE"
fi

# Read the encryption key
ENCRYPTION_KEY=$(cat "$ENCRYPTION_KEY_FILE")

# Encrypt the SQL file
openssl enc -aes-256-cbc -salt -pbkdf2 \
    -in "$DB_FILE" \
    -out "$ENCRYPTED_FILE" \
    -k "$ENCRYPTION_KEY"

echo "File encrypted: $ENCRYPTED_FILE"
