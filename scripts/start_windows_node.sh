#!/usr/bin/env bash
## get status of the instance
profile=$1;
workspaceId=$2;
echo "aws profile being used: $profile";
echo "workspaces id: $workspaceId";
state=$(aws workspaces describe-workspaces --workspace-ids $workspaceId --profile $profile | grep State);
available="AVAILABLE";
stopped="STOPPED";
stopping="STOPPING";
starting="STARTING";

## if State is available, no need to start it
if [[ $state =~ "$available" ]]; then
   echo "windows node is running already, no need to start: $state";
   exit 0;
elif [[ $state =~ "$stopped" ]]; then ## if State is stopped, start the workspace instance
   aws workspaces start-workspaces --start-workspace-requests WorkspaceId=$workspaceId --profile $profile;
   ## wait for the State to change to Available for 5 mins
   for i in `seq 100`
    do
      date;
      sleep 3;
      state=$(aws workspaces describe-workspaces --workspace-ids $workspaceId --profile $profile | grep State);
      echo "State: $state";
      if [[ $state =~ "$available" ]]; then
        echo "instance is available: $state";
        break;
      fi
    done
    if [[ $state != *"$available"* ]]; then
      echo "we waited 5 mins but the instance is still not coming up so non-zero exit";
      exit -1;
    fi
elif [[ $state =~ "$stopping" ]]; then ## if State is stopping, wait for it to become Stopped, then start the workspace instance
   ## wait for the State to change to Stopped 3 mins
   for i in `seq 60`
    do
      date;
      sleep 3;
      state=$(aws workspaces describe-workspaces --workspace-ids $workspaceId --profile $profile | grep State);
      echo "State: $state";
      if [[ $state =~ "$stopped" ]]; then
        echo "instance is stopped: $state";
        break;
      fi
    done
   ## now start the instance
   sleep 2;
   aws workspaces start-workspaces --start-workspace-requests WorkspaceId=$workspaceId --profile $profile;
   ## wait for the State to change to Available
   for i in `seq 100`
   do
     date;
     sleep 3;
     state=$(aws workspaces describe-workspaces --workspace-ids $workspaceId --profile $profile | grep State);
     echo "State: $state";
     if [[ $state =~ "$available" ]]; then
        echo "instance is available. we can start our tests: $state";
        break;
     fi
   done
   if [[ $state != *"$available"* ]]; then
     echo "after waiting for 5 mins but the instance still not coming up so non-zero exit: $state";
     exit -1;
   fi
else
   echo "not a state that I understand, not doing anything: $state";
   exit -1;
fi







