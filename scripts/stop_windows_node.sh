#!/usr/bin/env bash
## get status of the instance
state=$(aws workspaces describe-workspaces --profile us-dev | grep State);
available="AVAILABLE";
stopped="STOPPED";
stopping="STOPPING";
starting="STARTING";

if [[ $state =~ "$stopped" ]]; then
  echo "instance is stopped already. no need to stop again: $state";
  exit 0;
elif [[ $state =~ "$stopping" ]]; then
  echo "instance is in stopping state, just wait for it to stop: $state";
  for i in `seq 100`
  do
    date;
    sleep 3;
    state=$(aws workspaces describe-workspaces --profile aws.cmd.user | grep State);
    echo "State: $state";
    if [[ $state =~ "$stopped" ]]; then
      echo "instance is stopped: $state";
      break;
    fi
  done
  if [[ $state != *"$stopped"* ]]; then
    echo "instance is not stopping after 5 mins wait, non-zero exit: $state";
    exit -1;
  fi
elif [[ $state =~ "$available" ]]; then
  echo "instance state is $state, stopping it now";
  aws workspaces stop-workspaces --stop-workspace-requests WorkspaceId=ws-7wcdrl9h4 --profile us-dev;
  for i in `seq 100`
  do
    date;
    sleep 3;
    state=$(aws workspaces describe-workspaces --profile aws.cmd.user | grep State);
    echo "State: $state";
    if [[ $state =~ "$stopped" ]]; then
      echo "instance is stopped: $state";
      break;
    fi
  done
  if [[ $state != *"$stopped"* ]]; then
    echo "instance is not stopping after 5 mins wait, non-zero exit: $state";
    exit -1;
  fi
else
  echo "not a state that I understand, not doing anything: $state";
  exit -1;
fi