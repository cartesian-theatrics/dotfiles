#!/usr/bin/env bash

STATE=$(nmcli networking connectivity)

if [ $STATE = 'full' ]; then
  echo "Sending mail"
	~/.dotfiles/bin/msmtp-runqueue.sh
  echo "Syncing gmail"
  cd /home/emiller/.mail/gmail/
  gmi sync
  echo "Syncing eman"
  cd /home/emiller/.mail/eman/
  gmi sync
  echo "Syncing olypsis"
  cd /home/emiller/.mail/olypsis/
  gmi sync
  echo "Checking utd"
	mbsync -V utd
  echo "Running notmuch new"
	notmuch new
	notmuch tag +inbox -- to:eam150030@utdallas.edu AND not tag:inbox
	exit 0
fi
echo "No internet connection."
exit 0
