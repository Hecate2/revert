#!/bin/bash

set -e

# skip if no /revert
echo "Checking if contains '/revert' command..."
(jq -r ".comment.body" "$GITHUB_EVENT_PATH" | grep -E "/revert") || exit 78

HEAD_BRANCH="data"
REPO_FULLNAME="neoburger/burgernode"

git remote set-url origin https://x-access-token:$HECATE2_GITHUB_TOKEN_FOR_BURGERNODE_REVERT@github.com/$REPO_FULLNAME.git
git config --global user.email "revert@github.com"
git config --global user.name "GitHub Revert Action"

set -o xtrace

git fetch origin $HEAD_BRANCH

# do the revert
git checkout -b $HEAD_BRANCH origin/$HEAD_BRANCH

# check commit exists
# git cat-file -t $COMMIT_TO_REVERT
# git revert $COMMIT_TO_REVERT --no-edit

git cat-file -t e542e2eb2e937520a637de71b84a30ab2986b901
git revert e542e2eb2e937520a637de71b84a30ab2986b901 --no-edit
git cat-file -t 7c91a20b4a019a8bab4869f6124eccdd4281cef2
git revert 7c91a20b4a019a8bab4869f6124eccdd4281cef2 --no-edit
git cat-file -t 0d97ed12a4d561a76ade885d79d4451a63dfba42
git revert 0d97ed12a4d561a76ade885d79d4451a63dfba42 --no-edit

git push origin $HEAD_BRANCH
