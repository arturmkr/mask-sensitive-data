#!/bin/bash

# Check if the folder argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <target_directory>"
    exit 1
fi

TARGET_DIR="$1"

# Check if the provided directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory $TARGET_DIR does not exist."
    exit 1
fi

# Regex patterns for sensitive data
JWT_REGEX='eyJ[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+'
RSA_KEY_PATTERN='-----BEGIN RSA PRIVATE KEY-----[\s\S]+?-----END RSA PRIVATE KEY-----'
SENSITIVE_FIELDS_REGEX='"(token|jwt|privateKey|publicKey|password|privateCredentialValue)"\s*:\s*".*?"'

# Process JSON files
find "$TARGET_DIR" -type f -name '*.json' | while IFS= read -r FILE; do
    echo "Processing $FILE"

    # Mask sensitive fields by key
    perl -i -pe "s/$SENSITIVE_FIELDS_REGEX/\"\$1\": \"MASKED_SENSITIVE_DATA\"/g" "$FILE"

    # Remove JWT tokens within string values
    perl -i -pe "s/$JWT_REGEX/MASKED_SENSITIVE_DATA/g" "$FILE"

    # Remove private RSA keys within string values
    perl -0777 -i -pe "s#$RSA_KEY_PATTERN#MASKED_SENSITIVE_DATA#gs" "$FILE"
done

# Process HTML, text, and logs files
find "$TARGET_DIR" -type f \( -name '*.html' -o -name '*.txt' -o -name '*.logs' \) | while IFS= read -r FILE; do
    echo "Processing $FILE"

    # Remove JWT tokens
    perl -i -pe "s/$JWT_REGEX/MASKED_SENSITIVE_DATA/g" "$FILE"

    # Remove private RSA keys
    perl -0777 -i -pe "s#$RSA_KEY_PATTERN#MASKED_SENSITIVE_DATA#gs" "$FILE"
done

echo "Sensitive data masking complete."