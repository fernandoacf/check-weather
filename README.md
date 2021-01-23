
# Simple check weather puppet service

***
Needed: curl

This is a simple check of weather forecast using puppet to manage scripts that will query wttr.in every 1 minute using a variable definied as **$CITY** on check-weather.sh and save it to **$DIR**, you can adjust this to meet your needs. Puppet is also managing a backup service, it will setup cron schedule to run on a daily basis and keep only the 10 newest.

***
