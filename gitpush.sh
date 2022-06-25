#!/bin/bash

echo "Welcome to the GitHub File Publishing Tool (GHFP for short)"
read -p "Continue? " yn

case $yn in
[Yy]* ) echo "Continuing the program...";;
[Nn]* ) echo "Stopping the program"; exit;;
esac

echo "Your remote will be shown below."

git remote

read -p "What is the remote of your repository? See above for the remote. " REMOTE

echo "Your main branch will be shown below."

git remote show $REMOTE | sed -n '/HEAD branch/s/.*: //p'

read -p "What branch would you like to write changes to? For example, enter master for main/default branch. " BRANCH

echo "The number of commits for branch" $BRANCH "will show below."

git rev-list --count $BRANCH

git add .

read -r -p "Commit name/number/identifier: " NUM


git commit -m $NUM

git push
