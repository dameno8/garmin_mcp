#!/bin/sh
set -e

# Restore the Garmin token file from a base64 env var into the directory the
# server expects, so it can log in without an interactive terminal or MFA.
TOKEN_DIR="${GARMINTOKENS:-/root/.garminconnect}"

if [ -n "$GARMINTOKENS_BASE64" ]; then
  mkdir -p "$TOKEN_DIR"
  echo "$GARMINTOKENS_BASE64" | base64 -d > "$TOKEN_DIR/garmin_tokens.json"
  chmod 700 "$TOKEN_DIR"
  chmod 600 "$TOKEN_DIR/garmin_tokens.json"
  echo "Restored garmin_tokens.json into $TOKEN_DIR ($(wc -c < "$TOKEN_DIR/garmin_tokens.json") bytes)" >&2
fi

exec garmin-mcp
