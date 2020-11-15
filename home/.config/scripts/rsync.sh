#!/bin/bash

DAY=$(date +%A)

if [ -e /home/shellkr/bedrock-backup/$DAY ] ; then
  rm -fr /home/shellkr/bedrock-backup/$DAY
fi

rsync -ar --delete --quiet --inplace --backup --backup-dir=/home/shellkr/bedrock-backup/$DAY /home/shellkr/bedrock/worlds /home/shellkr/bedrock-backup


