#!/usr/bin/env bash
# setup-ollama.sh — Install Ollama and pull qwen2.5-coder:7b
set -euo pipefail

echo "==> Installing Ollama..."
if command -v ollama &>/dev/null; then
  echo "    Ollama is already installed ($(ollama --version)). Skipping install."
else
  curl -fsSL https://ollama.com/install.sh | sh
  echo "    Ollama installed successfully."
fi

echo "==> Pulling qwen2.5-coder:7b (~4.7 GB)..."
ollama pull qwen2.5-coder:7b

echo ""
echo "Done! To use the local fallback, set the following in ~/.config/opencode/config.json:"
echo '  "model": "ollama/qwen2.5-coder:7b"'
echo ""
echo "Ollama runs automatically in the background on http://localhost:11434"
