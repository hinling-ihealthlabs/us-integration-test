#!/usr/bin/env bash
date_prefix=`date +"%m.%d.%y.%H.%M"`;
echo "db host: $1";
echo "db name: $2";
echo "file prefix: $date_prefix";
mongodump --host $1 --port 27017 -d $2 --out ./$date_prefix.dump;