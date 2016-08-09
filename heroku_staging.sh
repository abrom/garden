#!/usr/bin/env bash

if [[ -n $(git status -s) ]]; then
  echo -n "There are uncomitted changes in the current branch. Are you sure you want to continue? [y/N]: "
  read checkuncommitted
  if [[ "$checkuncommitted" != "y" ]]; then
    exit
  fi
fi

echo -n "Deploy to Heroku? This will delete staging branch and recreate it before sending to heroku!! [Y/n]: "
read confirmation
if [[ "$confirmation" == "" || "$confirmation" == "y" || "$confirmation" == "Y" ]]; then
  git branch -D staging
  git checkout -b staging
  RAILS_ENV=production bundle exec rake assets:precompile
  git add .
  git commit -am "staging"
  git push -f heroku staging:master

  echo -n "Migrate database? [Y/n]: "
  read runmigration
  if [[ "$runmigration" == "" || "$runmigration" == "y" || "$confirmation" == "Y" ]]; then
    heroku run rake db:migrate --app plants-app
  fi

  git checkout master

  echo "All done."
fi
