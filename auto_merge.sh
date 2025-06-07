#!/bin/bash
BRANCH="feature-branch"
MERGE_AFTER="2025-11-10 00:00:00"
NOW=$(date +%s)
TARGET=$(date -d "$MERGE_AFTER" +%s)

if [ "$NOW" -ge "$TARGET" ]; then
  git checkout main
  git pull origin main
  git merge origin/$BRANCH --no-ff -m "Auto-merged $BRANCH after scheduled delay, Happy Birthday"
  git push origin main
  echo "Merged $BRANCH into main successfully."
  echo "Merged $BRANCH into main successfully." > merge.log
else
  echo "Not time yet $NOW, waiting for $TARGET"
  echo "Not time yet $NOW, waiting for $TARGET" > merge.log
fi

exit 0
