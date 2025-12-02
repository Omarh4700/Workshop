#!/bin/bash
# Script to encrypt db_backup.sql before committing to GitHub

set -e

DB_FILE="db_backup.sql"
ENCRYPTED_FILE="db_backup.sql.enc"
ENCRYPTION_KEY_FILE=".db_encryption_key"

# Check if db_backup.sql exists
if [ ! -f "$DB_FILE" ]; then
    echo "❌ Error: $DB_FILE not found!"
    exit 1
fi

# Generate encryption key if it doesn't exist
if [ ! -f "$ENCRYPTION_KEY_FILE" ]; then
    echo "🔑 Generating encryption key..."
    openssl rand -base64 32 > "$ENCRYPTION_KEY_FILE"
    echo "✅ Encryption key saved to $ENCRYPTION_KEY_FILE"
    echo ""
    echo "⚠️  IMPORTANT: Store this key in Jenkins Credentials!"
    echo "   Credential ID: db-encryption-key"
    echo "   Type: Secret text"
    echo "   Secret: $(cat $ENCRYPTION_KEY_FILE)"
fi

# Read the encryption key
ENCRYPTION_KEY=$(cat "$ENCRYPTION_KEY_FILE")

# Encrypt the SQL file
echo "🔒 Encrypting $DB_FILE..."
openssl enc -aes-256-cbc -salt -pbkdf2 \
    -in "$DB_FILE" \
    -out "$ENCRYPTED_FILE" \
    -k "$ENCRYPTION_KEY"

echo "✅ File encrypted successfully: $ENCRYPTED_FILE"
echo ""
echo "📋 Next steps:"
echo "1. Add encrypted file to git:"
echo "   git add $ENCRYPTED_FILE"
echo ""
echo "2. Store encryption key in Jenkins Credentials:"
echo "   - Go to Jenkins → Credentials → Add Credentials"
echo "   - ID: db-encryption-key"
echo "   - Type: Secret text"
echo "   - Secret: $(cat $ENCRYPTION_KEY_FILE)"
echo ""
echo "⚠️  DO NOT commit these files:"
echo "   - $DB_FILE (original)"
echo "   - $ENCRYPTION_KEY_FILE (key)"
