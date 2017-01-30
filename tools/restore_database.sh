#!/bin/sh

DAY=`LC_ALL=en_EN date +%A | tr '[:upper:]' '[:lower:]'`
FILENAME="cycling_pizza_$DAY.sql"

if [ $# -ne 4 ]
  then
    echo "USAGE:"
    echo "  Local:  restore_database.sh <Database host> <Database name> <RDS user> <TO local database name> "
    exit 1
else
  # Needed privileges on production
  # GRANT USAGE ON SCHEMA public to dev_name_ro;
  # GRANT SELECT ON ALL TABLES IN SCHEMA public TO dev_name_ro;
  # GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO dev_name_ro;
  # Create a ~/.pgpass and chmod 600 .pgpass
  # xxx.xxx.eu-west-1.rds.amazonaws.com:5432:weroom_production:username:password

  echo "Local restore"

  echo "Dump database from production to $FILENAME..."
  if ! pg_dump -F c -w -h $1 -p 5432 -d $2 -U $3 --no-owner --no-privileges -f /tmp/$FILENAME ; then
    echo "ERROR: Failed to dump production database!"
    exit 1
  else
    echo "Dump downloaded"
  fi

  echo "Restoring database from $FILENAME..."
  pg_restore --verbose --clean --no-acl --no-owner -d $4 /tmp/$FILENAME
  echo "Database restored"

  echo "Running migrations..."
  bundle exec rake db:migrate
  echo "Migrations run."

  rm /tmp/$FILENAME
  echo "Temporary file removed."
  echo "Finished restoring."
  exit 0
fi
