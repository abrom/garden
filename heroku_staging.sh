#!/usr/bin/env bash

if [[ -n $(git status -s) ]]; then
  echo -n "There are uncomitted changes in the current branch. Are you sure you want to continue? [y/N]: "
  read checkuncommitted
  if [[ "$checkuncommitted" != "y" ]]; then
    exit
  fi
fi

git push heroku master

echo -n "Migrate database? [Y/n]: "
read runmigration
if [[ "$runmigration" == "" || "$runmigration" == "y" || "$confirmation" == "Y" ]]; then
  heroku run rake db:migrate --app plants-app
fi

git checkout master

echo "All done."
