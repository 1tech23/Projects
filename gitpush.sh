#!/bin/bash

echo "Welcome to the GitHub File Publishing Tool (GHFP for short)"
read -p "Continue" yn

case $yn in
[Yy]* ) echo "Continuing the program...";;
[Nn]* ) echo "Stopping the program"; exit;;
esac

git add .

read -r -p "Commit name/number/identifier:" NUM


git commit -m $NUM

git push
