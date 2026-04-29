#!/bin/sh
# Corridor sessionStart — install the Corridor CLI if it isn't already installed.

if ! command -v corridor >/dev/null 2>&1 && [ ! -x "${HOME}/.corridor/bin/corridor" ]; then
  curl -fsSL https://app.corridor.dev/cli/install.sh | sh >/dev/null 2>&1 || true
fi

printf '{}\n'
