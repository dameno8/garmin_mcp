#!/bin/sh
set -e

# Restore Garmin OAuth tokens from base64 env vars into the directory the
# server expects, so it can log in without an interactive terminal or MFA.
TOKEN_DIR="${GARMINTOKENS:-/root/.garminconnect}"

if [ -n "$GARMIN_OAUTH1_BASE64" ] && [ -n "$GARMIN_OAUTH2_BASE64" ]; then
  mkdir -p "$TOKEN_DIR"
  echo "$GARMIN_OAUTH1_BASE64" | base64 -d > "$TOKEN_DIR/oauth1_token.json"
  echo "$GARMIN_OAUTH2_BASE64" | base64 -d > "$TOKEN_DIR/oauth2_token.json"
  chmod 700 "$TOKEN_DIR"
  chmod 600 "$TOKEN_DIR/oauth1_token.json" "$TOKEN_DIR/oauth2_token.json"
  echo "Restored Garmin oauth1/oauth2 tokens into $TOKEN_DIR" >&2
fi

exec garmin-mcp
