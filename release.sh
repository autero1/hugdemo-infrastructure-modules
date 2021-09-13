#!/usr/bin/env bash

# fail on unset variables and command errors
set -eu -o pipefail # -x: is for debugging

if [ "$(git branch --show-current)" != "main" ]; then
  echo "$0: Current branch is not main" 1>&2
  exit 1
fi

RELEASE_TYPE_LIST="prerelease prepatch patch preminor minor major premajor"
if command -v fzf; then
  RELEASE_TYPE=$(echo "${RELEASE_TYPE_LIST}" | tr ' ' '\n' | fzf --layout=reverse)
else
  select sel in ${RELEASE_TYPE_LIST}; do
    RELEASE_TYPE="${sel}"
    break
  done
fi

echo "$0: Create ${RELEASE_TYPE} release, continue? (y/n)"
read -r res
if [ "${res}" = "n" ]; then
  echo "$0: Stop script"
  exit 0
fi

git fetch origin
git pull origin main
git tag -d v0 || true
git pull origin --tags

npx standard-version --release-as "${RELEASE_TYPE}"

git push origin main
git push --follow-tags origin main


