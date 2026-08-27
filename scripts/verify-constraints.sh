#!/usr/bin/env bash
set -euo pipefail

npm run build

FAIL=0

check_absent() {
  if grep -riq --include='*.html' --include='*.css' --include='*.js' "$1" dist/ ; then
    echo "FAIL: found banned term '$1'"
    FAIL=1
  fi
}

check_present() {
  if ! grep -riq "$1" "$2" ; then
    echo "FAIL: missing required content '$1' in $2"
    FAIL=1
  fi
}

# Banned content: no sync/mobile mentions, no Inter font, no fake metrics language
check_absent "sync"
check_absent "mobile app"
check_absent "font-family:[^;]*inter"
check_absent "10x"
check_absent "testimonial"

# Required content per page
check_present "Flow is the point." dist/index.html
check_present "Real session recording goes here" dist/index.html
check_present "\\\$19 one-time" dist/pricing/index.html
check_present "No account required." dist/pricing/index.html
check_present "Attention doesn't move in a straight line" dist/about/index.html
check_present "System requirements go here" dist/download/index.html
check_present "Local-first. No accounts, no telemetry, no cloud." dist/index.html

if [ "$FAIL" -eq 1 ]; then
  echo "Constraint verification FAILED"
  exit 1
fi

echo "Constraint verification PASSED"
