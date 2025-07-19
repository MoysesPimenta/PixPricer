#!/usr/bin/env bash
# Bootstrap script to set up development environment
# Installs FVM, configures git hooks, and runs flutter pub get
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOOKS_DIR="$SCRIPT_DIR/hooks"

# Ensure pub cache bin in PATH for this session
export PATH="$HOME/.pub-cache/bin:$PATH"

if ! command -v fvm >/dev/null 2>&1; then
  echo "Installing FVM..."
  if command -v dart >/dev/null 2>&1; then
    dart pub global activate fvm
  elif command -v pub >/dev/null 2>&1; then
    pub global activate fvm
  else
    echo "Dart SDK not found. Please install Dart or Flutter."
    exit 1
  fi
fi

# Run flutter pub get using fvm if available
FVM_CMD="flutter"
if command -v fvm >/dev/null 2>&1; then
  FVM_CMD="fvm flutter"
fi

$FVM_CMD pub get

# Setup git hooks
if [ -d "$HOOKS_DIR" ]; then
  echo "Configuring git hooks..."
  for hook in "$HOOKS_DIR"/*; do
    hook_name="$(basename "$hook")"
    dest="$(git rev-parse --git-dir)/hooks/$hook_name"
    cp "$hook" "$dest"
    chmod +x "$dest"
  done
fi

echo "Bootstrap completed."
