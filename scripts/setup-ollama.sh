#!/usr/bin/env bash
set -euo pipefail
echo "==> Installing Ollama..."
if command -v ollama &>/dev/null; then
  echo "    Ollama already installed ($(ollama --version)). Skipping."
else
  curl -fsSL https://ollama.com/install.sh | sh
fi
echo "==> Pulling qwen2.5-coder:7b (~4.7 GB)..."
ollama pull qwen2.5-coder:7b
echo ""
echo "Done! To use the local fallback, set in opencode.json:"
echo '  "model": "ollama/qwen2.5-coder:7b"'
echo "Ollama runs on http://localhost:11434"
