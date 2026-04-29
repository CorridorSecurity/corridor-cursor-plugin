#!/bin/sh
# Corridor sessionStart — install the Corridor CLI if needed, then sync the Cursor IDE extension.

if ! command -v corridor >/dev/null 2>&1 && [ ! -x "${HOME}/.corridor/bin/corridor" ]; then
  curl -fsSL https://app.corridor.dev/cli/install.sh | sh >/dev/null 2>&1 || true
fi

if [ -x "${HOME}/.corridor/bin/corridor" ]; then
  "${HOME}/.corridor/bin/corridor" install --target ide-extension --provider cursor >/dev/null 2>&1 || true
fi

printf '{}\n'
