#!/bin/bash

# Designed to wrap another script and email a set of recipients upon success or failure, with the relevant output

if [[ $# -lt 2 ]]; then
  echo "Usage: email_wrapper.sh <recipients (space separated)> <script name>"
  exit 0
fi

EMAIL_RECIPIENTS=$1
WRAPPED_SCRIPT=$2
WRAPPED_SCRIPT_OUTPUT=$($WRAPPED_SCRIPT 2>&1)

send_email()
{
echo -e "$WRAPPED_SCRIPT_OUTPUT" | mail -s "$WRAPPED_SCRIPT $1" "$EMAIL_RECIPIENTS"
}

cd /usr/local/bin/ || exit 1
bash "$WRAPPED_SCRIPT" && send_email SUCCESS || send_email FAILURE

exit 0