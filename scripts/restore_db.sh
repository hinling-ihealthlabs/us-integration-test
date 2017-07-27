#!/usr/bin/env bash
# get the latest dump dir
echo "db host: $1";
echo "db name: $2";
dump_dir=`ls -tr | grep dump | tail -1`;
mongorestore --host $1 --port 27017 --db $2 --drop ./$dump_dir/$2
