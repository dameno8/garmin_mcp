#!/bin/sh
set -e

# If GARMINTOKENS_BASE64 is set, decode it into the expected token directory
# so the server can log in without an interactive terminal or MFA prompt.
TOKEN_DIR="${GARMINTOKENS:-/root/.garminconnect}"

if [ -n "$GARMINTOKENS_BASE64" ]; then
  mkdir -p "$TOKEN_DIR"
  echo "$GARMINTOKENS_BASE64" | base64 -d > "$TOKEN_DIR/garmin_tokens.json"
  chmod 700 "$TOKEN_DIR"
  chmod 600 "$TOKEN_DIR/garmin_tokens.json"
  echo "Restored Garmin tokens from GARMINTOKENS_BASE64 into $TOKEN_DIR" >&2
fi

exec garmin-mcp
