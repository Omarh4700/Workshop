#!/bin/bash
set -e
# Define file names
APP_FILE="application.properties"
ENCRYPTED_FILE="application.properties.enc"
ENCRYPTION_KEY_FILE=".app_encryption_key"
# Check if application.properties exists
if [ ! -f "$APP_FILE" ]; then
    exit 1
fi
# Generate encryption key if it doesn't exist
if [ ! -f "$ENCRYPTION_KEY_FILE" ]; then
    openssl rand -base64 32 > "$ENCRYPTION_KEY_FILE"
fi
# Read the encryption key
ENCRYPTION_KEY=$(cat "$ENCRYPTION_KEY_FILE")
# Encrypt the file
openssl enc -aes-256-cbc -salt -pbkdf2 \
    -in "$APP_FILE" \
    -out "$ENCRYPTED_FILE" \
    -k "$ENCRYPTION_KEY"
