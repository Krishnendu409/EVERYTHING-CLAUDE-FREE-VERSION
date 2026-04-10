# ECC — Free Version

> The full **Everything Claude Code** project ([affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code)) — all agents, skills, hooks, rules, and commands — pre-wired for **free models** instead of paid Claude APIs.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## Models

| Role | Model | Provider | Cost |
|------|-------|----------|------|
| Primary / large tasks | **Gemma 4 27B** (`google/gemma-4-27b-it`) | Google AI Studio | Free (rate-limited) |
| Fast / small tasks | **Qwen 2.5 Coder 7B** (`ollama/qwen2.5-coder:7b`) | Ollama (local) | Free (local GPU/CPU) |

---

## Quick Setup

### 1. Get a Google AI Studio key
Go to <https://aistudio.google.com> → Get API key → copy it.

### 2. Export the key
```bash
export GOOGLE_AI_STUDIO_KEY=your_key_here
```
Or copy `.env.example` to `.env` and fill it in (requires your shell to source it).

### 3. Install Ollama + pull the local model
```bash
bash scripts/setup-ollama.sh
```
This installs Ollama if needed and pulls `qwen2.5-coder:7b` (~4.7 GB).

### 4. Install OpenCode
```bash
npm i -g opencode
```

### 5. Run
```bash
opencode
```

---

## Switching Models

Edit `.opencode/opencode.json` — change the top-level `"model"` field:

```jsonc
// Use Gemma (default — needs GOOGLE_AI_STUDIO_KEY):
"model": "google/gemma-4-27b-it"

// Switch to fully-local Qwen when quota is exceeded:
"model": "ollama/qwen2.5-coder:7b"
```

---

## Check Your Quota
```bash
bash scripts/check-quota.sh
```

---

## What's Included

Everything from the upstream ECC project, unchanged:

| Directory | Contents |
|-----------|----------|
| `.opencode/` | OpenCode configuration (agents, commands, plugins) |
| `skills/` | 180+ reusable skill modules |
| `agents/` | Agent definitions |
| `rules/` | Coding rules and guidelines |
| `hooks/` | Lifecycle hooks |
| `commands/` | Slash-command templates |
| `contexts/` | Context files |
| `scripts/` | Setup and utility scripts |
| `.claude/` | Claude Code compatibility shims |
| `.cursor/` | Cursor IDE integration |
| `.kiro/` | Kiro IDE integration |
| `.gemini/` | Gemini CLI integration |
| `.agents/` | Multi-agent configs |

---

## Project Structure

```
.opencode/opencode.json   ← main config (model set to Gemma/Qwen)
scripts/setup-ollama.sh   ← install Ollama + pull qwen2.5-coder:7b
scripts/check-quota.sh    ← verify Google AI Studio quota
.env.example              ← copy to .env, fill GOOGLE_AI_STUDIO_KEY
```

---

## Credits

Original project: **[affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code)** by [@affaan-m](https://github.com/affaan-m).  
This repo substitutes the paid Anthropic/Claude models for free alternatives while keeping all agent logic, skills, rules, hooks, and commands intact.

---

## License

MIT — see [LICENSE](LICENSE).
