#!/bin/sh
set -e

CONFIG=/config/emailproxy.config

# Only render the template on first run - preserve cached tokens on subsequent starts
if [ ! -f "$CONFIG" ]; then
    echo "[entrypoint] First run: rendering config from template"
    envsubst '${TENANT_ID} ${CLIENT_ID}' < /emailproxy.config.template > "$CONFIG"
else
    echo "[entrypoint] Config already exists, keeping cached tokens"
fi

echo "[entrypoint] Starting email-oauth2-proxy..."
exec emailproxy --no-gui --config "$CONFIG" --external-auth
