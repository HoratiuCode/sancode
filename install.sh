#!/bin/sh
# SanCode installer: finds your agents and installs the skill into each.
#   curl -fsSL https://raw.githubusercontent.com/HoratiuCode/sancode/main/install.sh | sh
#   ... | sh -s -- --update | --uninstall | --only claude,hermes | --zip (for Claude chat/Cowork upload)
set -eu

REPO="HoratiuCode/sancode"
REF="${SANCODE_REF:-main}"
MODE="install"
ONLY=""

while [ $# -gt 0 ]; do
  case "$1" in
    --update) MODE="update" ;;
    --uninstall) MODE="uninstall" ;;
    --zip) MODE="zip" ;;
    --only) ONLY="$2"; shift ;;
    -h|--help) sed -n '2,4p' "$0" 2>/dev/null || true; exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
  shift
done

# agent | home folder that proves it's installed | skill target
AGENTS="claude|$HOME/.claude|$HOME/.claude/skills/sancode
hermes|$HOME/.hermes|$HOME/.hermes/skills/sancode
openclaw|$HOME/.openclaw|$HOME/.openclaw/workspace/skills/sancode"

version_of() { sed -n 's/^ *version: *"\{0,1\}\([0-9.]*\).*/\1/p' "$1/SKILL.md" 2>/dev/null | head -1; }

# Use the local copy when run from a clone, otherwise download.
SRC=""
case "$0" in
  *install.sh) [ -f "$(dirname "$0")/skill/sancode/SKILL.md" ] && SRC="$(cd "$(dirname "$0")" && pwd)/skill/sancode" ;;
esac
if [ -z "$SRC" ] && [ "$MODE" != "uninstall" ]; then
  TMP="$(mktemp -d)"
  trap 'rm -rf "$TMP"' EXIT
  curl -fsSL "https://codeload.github.com/$REPO/tar.gz/$REF" | tar -xz -C "$TMP"
  SRC="$(find "$TMP" -path '*/skill/sancode' -type d | head -1)"
  [ -n "$SRC" ] || { echo "Download failed: skill/sancode not found." >&2; exit 1; }
fi
NEW="$(version_of "${SRC:-/nonexistent}")"

# Claude chat / Cowork: build a zip with the sancode/ folder at its root.
if [ "$MODE" = "zip" ]; then
  OUT="$(pwd)/sancode.zip"
  rm -f "$OUT"
  ( cd "$(dirname "$SRC")" && if command -v zip >/dev/null 2>&1; then zip -qr "$OUT" sancode -x '*.DS_Store'
    else python3 -m zipfile -c "$OUT" sancode; fi )
  echo "SanCode v$NEW -> $OUT"
  echo "Upload it at claude.ai: Settings > Capabilities > Skills. It shows up in Cowork too."
  exit 0
fi

case "$MODE" in install) echo "SanCode installer" ;; update) echo "SanCode updater" ;; uninstall) echo "SanCode uninstaller" ;; esac
echo "$AGENTS" | while IFS='|' read -r name home target; do
  [ -n "$ONLY" ] && case ",$ONLY," in *",$name,"*) ;; *) continue ;; esac
  label="$(printf '%-12s' "$name")"
  if [ ! -d "$home" ]; then
    echo "[ ] $label not found"
    continue
  fi
  old="$(version_of "$target")"
  case "$MODE" in
    uninstall)
      if [ -d "$target" ]; then rm -rf "$target"; echo "[-] $label removed"
      else echo "[ ] $label not installed"; fi ;;
    *)
      mkdir -p "$(dirname "$target")"
      rm -rf "$target"
      cp -R "$SRC" "$target"
      if [ -n "$old" ] && [ "$old" != "$NEW" ]; then echo "[x] $label $old -> $NEW   $target"
      else echo "[x] $label v$NEW   $target"; fi ;;
  esac
done

case "$MODE" in
  install) echo "Done. Open any project and ask for code: SanCode runs setup on first use." ;;
  update) echo "Done. Your brain files upgrade themselves on the next task." ;;
  uninstall) echo "Done. Project brain files (.sancode/) were left untouched." ;;
esac
