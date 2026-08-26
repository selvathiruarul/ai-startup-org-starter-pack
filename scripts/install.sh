#!/usr/bin/env bash
# Org Starter Pack installer
# Creates one Hermes Agent profile per bot soul and installs its SOUL.md.
#
# Usage:
#   ./scripts/install.sh                 # install all 8 profiles
#   ./scripts/install.sh ceo qa          # install a subset
#
# Requires: hermes CLI on PATH. Version-pinned behavior: the installer relies
# only on `hermes profile create` flags stable since v0.20.x and verifies the
# hermes version before running.

set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOULS_DIR="$HERE/souls"
PINNED_MIN="0.20.0"
ALL_BOTS=(ceo cfo critic cto deploy dev market-analyst qa)

# --- preflight -------------------------------------------------------------

command -v hermes >/dev/null 2>&1 || {
  echo "ERROR: 'hermes' CLI not found on PATH. Install Hermes Agent first:" >&2
  echo "  https://hermes-agent.nousresearch.com/docs" >&2
  exit 1
}

HERMES_VERSION="$(hermes --version 2>/dev/null | head -1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' || true)"
if [[ -z "$HERMES_VERSION" ]]; then
  echo "WARNING: could not detect hermes version; continuing (pinned >= $PINNED_MIN)." >&2
elif ! printf '%s\n%s\n' "$PINNED_MIN" "$HERMES_VERSION" | sort -V | head -1 | grep -q "^$PINNED_MIN$"; then
  echo "ERROR: hermes $HERMES_VERSION is older than the pinned minimum $PINNED_MIN." >&2
  exit 1
fi

# --- parse args ------------------------------------------------------------

BOTS=("$@")
((${#BOTS[@]})) || BOTS=("${ALL_BOTS[@]}")

for bot in "${BOTS[@]}"; do
  soul="$SOULS_DIR/$bot.md"
  [[ -f "$soul" ]] || { echo "ERROR: no soul file for '$bot' (expected $soul)" >&2; exit 1; }
done

# --- install ---------------------------------------------------------------

for bot in "${BOTS[@]}"; do
  soul="$SOULS_DIR/$bot.md"
  desc="Org Starter Pack bot: $bot"

  if hermes profile show "$bot" >/dev/null 2>&1; then
    echo "[$bot] profile exists — updating SOUL.md only."
    PROFILE_DIR="$(hermes profile show "$bot" 2>/dev/null | grep -oE '/[^ ]*profiles/[^ ]*'"$bot" | head -1 || true)"
    if [[ -n "$PROFILE_DIR" ]]; then
      cp "$soul" "$PROFILE_DIR/SOUL.md"
      echo "[$bot] SOUL.md updated at $PROFILE_DIR/SOUL.md"
    else
      echo "[$bot] WARNING: could not resolve profile dir; copy $soul manually." >&2
    fi
    continue
  fi

  echo "[$bot] creating profile..."
  hermes profile create "$bot" \
    --no-skills \
    --description "$desc" >/dev/null

  PROFILE_DIR="$HOME/.hermes/profiles/$bot"
  if [[ ! -d "$PROFILE_DIR" ]]; then
    # Fallback: ask hermes where it put it.
    PROFILE_DIR="$(hermes profile list 2>/dev/null | awk -v b="$bot" '$1==b {print $NF}')"
  fi
  [[ -n "$PROFILE_DIR" && -d "$PROFILE_DIR" ]] || {
    echo "[$bot] ERROR: profile dir not found after creation." >&2; exit 1; }

  cp "$soul" "$PROFILE_DIR/SOUL.md"
  echo "[$bot] installed → $PROFILE_DIR/SOUL.md"
done

echo
echo "Done. Installed bots: ${BOTS[*]}"
echo "Next: run 'hermes' with profile 'ceo' and pitch it an idea."
