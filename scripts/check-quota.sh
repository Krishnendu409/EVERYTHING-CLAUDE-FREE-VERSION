#!/usr/bin/env bash
# check-quota.sh — Check remaining Google AI Studio free-tier quota for Gemma 4.
#
# Usage:
#   GOOGLE_AI_STUDIO_KEY=<your-key> bash scripts/check-quota.sh
#   or export the key first:
#   export GOOGLE_AI_STUDIO_KEY=<your-key>
#   bash scripts/check-quota.sh
set -euo pipefail

API_KEY="${GOOGLE_AI_STUDIO_KEY:-}"

if [ -z "$API_KEY" ]; then
  # Try to read from the OpenCode config as a convenience
  CONFIG_FILE="${HOME}/.config/opencode/config.json"
  if [ -f "$CONFIG_FILE" ] && command -v jq &>/dev/null; then
    API_KEY=$(jq -r '.providers.google.apiKey // empty' "$CONFIG_FILE")
  fi
fi

if [ -z "$API_KEY" ] || [ "$API_KEY" = "YOUR_AI_STUDIO_KEY" ]; then
  echo "Error: Google AI Studio API key not found."
  echo "Set it with:  export GOOGLE_AI_STUDIO_KEY=<your-key>"
  exit 1
fi

echo "==> Sending a minimal test request to Google AI Studio..."
RESPONSE=$(curl -s -w "\n%{http_code}" \
  -H "Content-Type: application/json" \
  -H "x-goog-api-key: ${API_KEY}" \
  -d '{"contents":[{"parts":[{"text":"hi"}]}],"generationConfig":{"maxOutputTokens":1}}' \
  "https://generativelanguage.googleapis.com/v1beta/models/gemma-4-27b-it:generateContent")

HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
BODY=$(echo "$RESPONSE" | head -n-1)

if [ "$HTTP_CODE" = "200" ]; then
  echo "✅  Quota OK — Gemma 4 27B is reachable and responding."
elif [ "$HTTP_CODE" = "429" ]; then
  echo "⚠️  Quota exceeded (HTTP 429). Free daily limit reached."
  echo "    Quota resets at midnight Pacific Time."
  echo "    Switch to the local fallback:"
  echo '      Set "model": "ollama/qwen2.5-coder:7b" in ~/.config/opencode/config.json'
else
  echo "Unexpected response (HTTP $HTTP_CODE):"
  echo "$BODY" | (command -v jq &>/dev/null && jq . || cat)
  exit 1
fi
