#!/usr/bin/env bash

CURRENT_BRANCH=$(git branch --show-current)
if [ "${CURRENT_BRANCH}" != "master" ] && [ "${CURRENT_BRANCH}" != "main" ]; then
    echo "Not in master/main default branch. Aborting."
    exit 1
fi

BRANCH_NAME="chore/update-gh-definitions-$(date '+%s')"

git checkout -b "${BRANCH_NAME}"

go run main.go

if [ "$(git status --porcelain | wc -l)" != "1" ]; then
    echo "Found more changes than expected. Aborting."
    exit 1
fi

git commit -am "Update GH definitions"

git push origin "${BRANCH_NAME}"
