#!/usr/bin/env bash
# sync-from-private.sh
# Copies source file changes from the private CRA-Compliance-Tool repo into this
# public crane-oss repo. Run this after fixing bugs in the private repo.
#
# Usage:
#   cd /home/ali/Desktop/crane-oss
#   bash scripts/sync-from-private.sh
#   # review the diff, then:
#   git commit -m "fix: <describe what you synced>"
#   git push origin main

set -euo pipefail

PRIVATE="/home/ali/Desktop/CRA Project/CRA-Compliance-Tool"
PUBLIC="$(cd "$(dirname "$0")/.." && pwd)"

echo "Syncing from: $PRIVATE"
echo "Into:         $PUBLIC"
echo ""

# -- Backend Python source files --
BACKEND_FILES=(
  "backend/requirements.txt"
  "backend/app/api/routes/product_releases.py"
  "backend/app/api/routes/lifecycle_notifications.py"
  "backend/app/repositories/lifecycle_notification_repository.py"
  "backend/app/services/lifecycle_notification_service.py"
  "backend/app/templates/release_report.html"
  # Add more backend files below as needed:
  # "backend/app/models/product.py"
  # "backend/app/schemas/product.py"
)

# -- Frontend source files --
FRONTEND_FILES=(
  "frontend/src/services/release-gate-service.ts"
  "frontend/src/views/SecurityUpdateHistoryView.vue"
  # Add more frontend files below as needed:
  # "frontend/src/views/ProductDetailView.vue"
  # "frontend/src/types/product.ts"
)

ALL_FILES=("${BACKEND_FILES[@]}" "${FRONTEND_FILES[@]}")

CHANGED=()

for FILE in "${ALL_FILES[@]}"; do
  SRC="$PRIVATE/$FILE"
  DST="$PUBLIC/$FILE"

  if [ ! -f "$SRC" ]; then
    echo "  SKIP  $FILE  (not found in private repo)"
    continue
  fi

  # Only copy if the file actually differs
  if ! diff -q "$SRC" "$DST" > /dev/null 2>&1; then
    cp "$SRC" "$DST"
    echo "  UPDATED  $FILE"
    CHANGED+=("$FILE")
  else
    echo "  ok       $FILE"
  fi
done

echo ""

if [ ${#CHANGED[@]} -eq 0 ]; then
  echo "Nothing changed — both repos are already in sync."
  exit 0
fi

echo "${#CHANGED[@]} file(s) updated. Staged for commit:"
git -C "$PUBLIC" add "${CHANGED[@]}"
git -C "$PUBLIC" diff --cached --stat
echo ""
echo "Review the diff above, then run:"
echo "  git commit -m \"fix: <describe what you synced>\""
echo "  git push origin main"
