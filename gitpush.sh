#!/bin/bash -e

echo "Welcome to the GitHub File Publishing Tool (GHFP for short)"

set -e $yn Yy

read -p "Continue? Default is y. " yn

case $yn in
[Yy]* ) echo "Continuing the program...";;
[Nn]* ) echo "Stopping the program"; exit;;
esac

REMOTE=$(git remote)

BRANCH=$(git remote show $REMOTE | grep 'HEAD branch' | cut -d' ' -f5)

NUM=$(git rev-list --count $BRANCH)

NUM1=$(($NUM + 1))

git add -u

git commit -m $NUM1

git push