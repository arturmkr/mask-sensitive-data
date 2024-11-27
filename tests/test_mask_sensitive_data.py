import os
import re
import pytest

TARGET_DIR = "../sensitive-files"
SENSITIVE_STRINGS = [
    "qwertyadmin",
    "eyJhbGciOiJFUzUxMiIsInR5cCI6IkpXVCJ9",
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9",
    "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9",
    "eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCJ9",
    "eyJhbGciOiJFUzUxMiIsInR5cCI6IkpXVCJ9",
    "eyJhbGciOiJQUzUxMiIsInR5cCI6IkpXVCJ9",
    "MIICXAIBAAKBgQCUxgsf6HByx2NeejEVBut5JYZLmTy1jvswlpeZH6",
]

@pytest.mark.parametrize("file_extension", ["html", "txt", "logs", "json"])
def test_sensitive_data_removed(file_extension):
    # Recursively find all files with the given extension in the TARGET_DIR
    for root, _, files in os.walk(TARGET_DIR):
        for file in files:
            if file.endswith(f".{file_extension}"):
                with open(os.path.join(root, file), "r") as f:
                    content = f.read()
                    # Check if any sensitive strings are present
                    for sensitive_string in SENSITIVE_STRINGS:
                        assert re.search(sensitive_string, content) is None, f"Sensitive data found in {file}"
