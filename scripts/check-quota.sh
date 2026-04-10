#!/usr/bin/env bash
set -euo pipefail
API_KEY="${GOOGLE_AI_STUDIO_KEY:-}"
if [ -z "$API_KEY" ]; then
  CONFIG_FILE="${HOME}/.config/opencode/config.json"
  if [ -f "$CONFIG_FILE" ] && command -v jq &>/dev/null; then
    API_KEY=$(jq -r '.providers.google.apiKey // empty' "$CONFIG_FILE")
  fi
fi
if [ -z "$API_KEY" ] || [ "$API_KEY" = "YOUR_AI_STUDIO_KEY" ]; then
  echo "Error: GOOGLE_AI_STUDIO_KEY not set."
  exit 1
fi
echo "==> Testing Google AI Studio..."
RESPONSE=$(curl -s -w "\n%{http_code}" \
  -H "Content-Type: application/json" \
  -H "x-goog-api-key: ${API_KEY}" \
  -d '{"contents":[{"parts":[{"text":"hi"}]}],"generationConfig":{"maxOutputTokens":1}}' \
  "https://generativelanguage.googleapis.com/v1beta/models/gemma-4-27b-it:generateContent")
HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
if [ "$HTTP_CODE" = "200" ]; then
  echo "✅  Quota OK — Gemma 4 27B is available."
elif [ "$HTTP_CODE" = "429" ]; then
  echo "⚠️  Quota exceeded. Switch to: ollama/qwen2.5-coder:7b"
else
  echo "Unexpected HTTP $HTTP_CODE"
  exit 1
fi
