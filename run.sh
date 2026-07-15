#!/usr/bin/env bash
set -euo pipefail

PORT="${PORT:-8000}"
HOST="${HOST:-127.0.0.1}"

cd "$(dirname "$0")"

./scripts/generate-index.sh

echo "Serving treasure-hunt from: $(pwd)"
echo "Open: http://${HOST}:${PORT}/"
echo "Museum Heist: http://${HOST}:${PORT}/museum-heist/mission.html"
echo "Parent answer key: http://${HOST}:${PORT}/museum-heist/answer.html"
echo
echo "Stop with Ctrl+C."

python3 -m http.server "$PORT" --bind "$HOST"
