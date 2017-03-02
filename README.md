# README

Fetching data such as velib usage and weather to be able to predict velib availability.

## Status

[![Build Status](https://travis-ci.org/sallesma/cycling-pizza.svg?branch=master)](https://travis-ci.org/sallesma/cycling-pizza)
[![Code Climate](https://codeclimate.com/github/sallesma/cycling-pizza/badges/gpa.svg)](https://codeclimate.com/github/sallesma/cycling-pizza)
[![Dependency Status](https://gemnasium.com/badges/github.com/sallesma/cycling-pizza.svg)](https://gemnasium.com/github.com/sallesma/cycling-pizza)

## Development

You may use Vagrant or the app directly

Model annotations
```
bundle exec annotate -ik
```

Extract previous day data
```
psql -d cycling_pizza_dev -A -F"," -f tools/previous_day_velib.sql -o velib_2017-03-01.csv

```

## Deployment

Populate the holidays table
```
cd /var/app/current && bundle exec thor holiday:populate
```

Set up cronjobs to fetch stations and weather periodically
```
*/10 * * * * source /opt/elasticbeanstalk/support/envvars && cd /var/app/current && bundle exec thor stations:fetch
*/10 * * * * source /opt/elasticbeanstalk/support/envvars && cd /var/app/current && bundle exec thor weather:fetch
```
