# EVERYTHING-CLAUDE-FREE-VERSION

A free AI coding assistant setup using **Gemma 4 27B** (via Google AI Studio) as the primary model, with **Qwen 2.5 Coder 7B** (via Ollama, local) as the fallback when the free quota runs out.

---

## Models

| | Gemma 4 27B (Primary) | Qwen 2.5 Coder 7B (Fallback) |
|---|---|---|
| Provider | Google AI Studio (cloud) | Ollama (local) |
| Cost | Free — 1,500 req/day | Free forever |
| Context window | 128K tokens | 32K tokens |
| Code quality | Excellent | Good |
| Speed | Fast (cloud GPU) | ~5–15 tok/s on CPU |
| Privacy | Google sees your code | 100% local |
| Works offline | No | Yes |

---

## Prerequisites

- [Node.js](https://nodejs.org) ≥ 18
- [OpenCode](https://github.com/sst/opencode) (`npm i -g opencode`)
- A free [Google AI Studio](https://aistudio.google.com) API key
- [Ollama](https://ollama.com) (for the local fallback)

---

## Setup

### 1. Get your free Google AI Studio API key

1. Go to [aistudio.google.com](https://aistudio.google.com) and sign in with a Google account.
2. Click **"Get API key"** → **"Create API key"**.
3. Copy the key — you'll need it in the next step.

Free tier limits: **1,500 requests/day**, **1,000,000 tokens/minute**.

### 2. Configure OpenCode

Copy the template and fill in your key:

```bash
mkdir -p ~/.config/opencode
cp opencode.json ~/.config/opencode/config.json
```

Then open `~/.config/opencode/config.json` and replace `YOUR_AI_STUDIO_KEY` with your real key.

### 3. Install the Ollama fallback

```bash
bash scripts/setup-ollama.sh
```

This installs Ollama and pulls the `qwen2.5-coder:7b` model (~4.7 GB). Requires ~7 GB of RAM.

### 4. Start coding

```bash
opencode
```

---

## Switching Between Models

**Primary (Gemma 4 27B — cloud):**

```bash
# In ~/.config/opencode/config.json, set:
"model": "google/gemma-4-27b-it"
```

**Fallback (Qwen 2.5 Coder 7B — local):**

```bash
# In ~/.config/opencode/config.json, set:
"model": "ollama/qwen2.5-coder:7b"
```

Only one line changes — all skills, rules, and hooks stay the same.

### Check your AI Studio quota

```bash
bash scripts/check-quota.sh
```

AI Studio quota resets daily at **midnight Pacific Time**.

---

## Files

```
opencode.json               OpenCode config template (copy to ~/.config/opencode/config.json)
scripts/
  setup-ollama.sh           Installs Ollama and pulls qwen2.5-coder:7b
  check-quota.sh            Checks remaining Google AI Studio free quota
```
