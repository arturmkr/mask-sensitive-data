# Mask Sensitive Data Script

A script to mask or remove sensitive data from files in a specified directory. It processes JSON, HTML, text, and log files, replacing sensitive content such as JWT tokens, passwords, RSA private keys, and specific fields with a placeholder.

## Features
- Masks sensitive fields by key (e.g., `token`, `jwt`, `privateKey`, `password`).
- Removes JWT tokens, passwords, and RSA private keys from file contents.
- Processes files with extensions `.json`, `.html`, `.txt`, and `.logs`.

## Requirements
- **Perl**: Ensure Perl is installed on your system.

## Usage
1. Make the script executable:
   ```bash
   chmod +x mask_sensitive_data.sh
   ```
2. Run the script with the target directory as an argument:
   ```bash
    ./mask_sensitive_data.sh /path/to/target/directory
   ```
3. The script will recursively process all matching files in the specified directory and mask sensitive data.

Examples
   ```bash
    ./mask_sensitive_data.sh ./sensitive-files
   ```

## Output
All sensitive data in the processed files will be replaced with the placeholder MASKED_SENSITIVE_DATA.
