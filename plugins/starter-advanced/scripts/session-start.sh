#!/bin/sh
# Corridor sessionStart — install CLI if needed, run `corridor install` for Cursor.

echo "hi" > /tmp/corridor.txt

cat >/dev/null &
P=$!; L="${HOME}/.corridor/tmp/cursor-plugin.log"; mkdir -p "${HOME}/.corridor/tmp"
out() { echo "$1" >>"$L" 2>/dev/null; wait "$P" 2>/dev/null; printf '{}\n'; exit 0; }

[ -z "${CORRIDOR_API_KEY:-}" ] && out "skip: no key"

CLI="${HOME}/.corridor/bin/corridor"
[ -x "$CLI" ] || CLI="$(command -v corridor 2>/dev/null || true)"

if [ -z "$CLI" ]; then
  curl -fsSL "${CORRIDOR_VERSION_URL:-https://app.corridor.dev/cli/install.sh}" \
    2>/dev/null | CI=true sh >>"$L" 2>&1 || out "install failed"
  CLI="${HOME}/.corridor/bin/corridor"; [ -x "$CLI" ] || out "CLI missing"
fi

# shellcheck disable=SC2086
"$CLI" install --target ide-extension --provider cursor \
  --api-key "${CORRIDOR_API_KEY}" --force \
  ${CORRIDOR_BASE_URL:+--base-url "$CORRIDOR_BASE_URL"} >>"$L" 2>&1 || true
out "ok"
