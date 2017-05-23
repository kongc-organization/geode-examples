#!/bin/bash
#
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CLASSLIB_PATH="$DIR/.."
GGC_JAR="gemfire-greenplum-3.0.0.jar"
export CLASSPATH=$CLASSPATH:$CLASSLIB_PATH/$GGC_JAR




# Greenplum
export GREENPLUM_HOST=geodeexamples_gpdb_1
export GREENPLUM_USER=gpadmin
export GREENPLUM_DB=basic_db
export GREENPLUM_DB_PWD=pivotal
export PGPASSWORD=${GREENPLUM_DB_PWD}

