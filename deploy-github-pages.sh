#!/usr/bin/env bash
set -euo pipefail

REPO_NAME="${1:-fixture-basquet-voley}"

gh auth status
OWNER="$(gh api user --jq .login)"

gh repo create "$OWNER/$REPO_NAME" --public --source=. --remote=origin --push
gh api \
  --method POST \
  "repos/$OWNER/$REPO_NAME/pages" \
  -f "source[branch]=main" \
  -f "source[path]=/"

echo "GitHub Pages deploy requested for $REPO_NAME."
echo "Site URL: https://$OWNER.github.io/$REPO_NAME/"
echo "If the page is still building, check: https://github.com/$OWNER/$REPO_NAME/actions"
