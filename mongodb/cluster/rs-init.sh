#!/bin/bash

mongosh <<EOF
var config = {
    "_id": "dbrs",
    "version": 1,
    "members": [
        {
            "_id": 1,
            "host": "mongo1:27017",
            "priority": 3
        },
        {
            "_id": 2,
            "host": "mongo2:27017",
            "priority": 2
        },
        {
            "_id": 3,
            "host": "mongo3:27017",
            "priority": 1
        }
    ]
};
rs.initiate(config, { force: true });
rs.status();
EOF

# use admin

rs.initiate(
  {
     _id: "replicaset",
     version: 1,
     members: [
        { _id: 0, host : "mongo1" },
        { _id: 1, host : "mongo2" },
        { _id: 2, host : "mongo3" }
     ]
  }
)