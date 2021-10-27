#!/bin/bash

DEFAULT_FILE_CONFIG="/etc/nginx/nginx.conf"
PATH_TO_BACKUP="/tmp/nginx.conf"


copy_config_file() {
  echo "Copying file..."
  cp $DEFAULT_FILE_CONFIG $PATH_TO_BACKUP

  # check if backup is stored
  if [ $? -ne 0 ]; then
    echo "Error. Backup wasn't stored"
  else
    echo "Backup has stored!"
  fi
}


restart_nginx_from_backup() {
  echo "Restore configs from backup"
  sudo cp $PATH_TO_BACKUP $DEFAULT_FILE_CONFIG
  sudo systemctl start nginx
  if [ $? -eq 0 ]; then
      echo "Success! Nginx has started!"
  else
    echo "Error! Nginx hasn't started !!!"
  fi
}


start_nginx() {
  SUCCESS=0
  echo "Error. Backup wasn't stored"
  for i in $(seq 1 2)
    do
    echo "Sleep 1 minute..."
    sleep 1m
    echo "Trying to start nginx..."
    sudo systemctl start nginx
    if [ $? -eq 0 ]; then
      echo "Success! Nginx has started!"
      SUCCESS=1
      break
    else
      echo "Error! Nginx hasn't started !!!"
    fi
  done

  if [ $SUCCESS -eq 0 ]; then
    restart_nginx_from_backup
  fi
}


run_nginx() {
  sudo systemctl start nginx
  # check if start/restart wasn't successful
  if [ $? -ne 0 ]; then
    start_nginx
  else
    echo "Success! Nginx has started!"
  fi
}


add_script_to_cron() {
  echo
}


# i. Script should hold your current nginx web site
# configuration
copy_config_file

# ii Script should check if nginx running and restart
# it if it’s not.

# iii. If nginx failed to restart, try two times more (with
# one minute delay) and reset it’s configuration to
# predefined (section i) with additional restart
# after config update.
pgrep -x nginx >/dev/null && echo "Nginx running" || run_nginx

# iv. Script should add it self to cron for execution
# each 5 minutes
