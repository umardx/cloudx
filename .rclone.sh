#!/bin/sh
PIDFILE=/tmp/.rclone.pid
RCLONE_DIR=~/.config/rclone

# --- write rclone config file ---
create_rclone_config() {
  if [ ! -f $RCLONE_DIR/rclone.conf ]; then
  mkdir -p $RCLONE_DIR >/dev/null
  tee ~/.config/rclone/rclone.conf >/dev/null << EOF
[drive]
type = drive
scope = drive
token = {"access_token":"ya29.ImC5Bzv49Ooa2_XlXvToA1GwnKdvEaDCZGoxECCDs9JSxScR5aCLK9jFLdKabbxAnlPCezLmGmI-vD7qMzpetz6s8A98t3sAr3jsSxrPwFgueqzQ-Z4fNiYrByOca7KncjI","token_type":"Bearer","refresh_token":"1//0gg338Y77C4VDCgYIARAAGBASNwF-L9IrHuTjcI319iPuBhmfveJ62u0BmphTITvRLtedIYmw8sI0w4u87SNJiKV78GeT49gRtS0","expiry":"2020-01-16T17:00:00.241388518+07:00"}
root_folder_id = 1_S_Yj7N5qu08IbRtEV-qpxTDhvRWjA4R
EOF
  fi
}

run_rclone() {
  if [ -f $PIDFILE ]
  then
    PID=$(cat $PIDFILE)
    ps -p $PID > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
      echo "Process already running"
      exit 1
    else
      ## Process not found assume not running
      echo $$ > $PIDFILE
      if [ $? -ne 0 ]
      then
        echo "Could not create PID file"
        exit 1
      fi
    fi
  else
    echo $$ > $PIDFILE
    if [ $? -ne 0 ]
    then
      echo "Could not create PID file"
      exit 1
    fi
  fi
  rclone copy --exclude *.db ./downloads drive:/downloads

  rm $PIDFILE
}

create_rclone_config
run_rclone