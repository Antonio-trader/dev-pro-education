#!/bin/bash

# iv. Script should add itself to cron for execution
# each 5 minutes
echo "*/5 * * * * root bash ./nginx_script.sh" >> /etc/crontab