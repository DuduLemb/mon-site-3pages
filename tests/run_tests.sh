#!/bin/bash
set -e
# tests/run_tests.sh
[[ -f index.html ]] || { echo "index.html missing"; exit 1; }
grep -q "<html" index.html || { echo "index.html doesn't contain <html>"; exit 1; }
echo "Tests passed"
