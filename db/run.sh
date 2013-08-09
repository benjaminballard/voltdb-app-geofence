#!/usr/bin/env bash

. ./env.sh

CATALOG_NAME="example"

# remove build artifacts
function clean() {
    rm -rf obj log debugoutput statement-plans voltdbroot ${CATALOG_NAME}.jar catalog-report.html
}

# compile any java source code and the catalog
function compile() {
    # compile java code to obj directory
    if find . | grep .java &> /dev/null; then
        SRC=`find . | grep .java`
        mkdir -p obj
        javac -classpath $CLASSPATH -d obj $SRC
        # stop if compilation fails
        if [ $? != 0 ]; then exit; fi
    fi
    # compile catalog
    if [ -f ddl.sql ]; then
        voltdb compile --classpath obj -o ${CATALOG_NAME}.jar ddl.sql
        # stop if compilation fails
        if [ $? != 0 ]; then exit; fi
    fi
}


function server() {
    compile
    voltdb create catalog ${CATALOG_NAME}.jar \
        license $VOLTDB_HOME/voltdb/license.xml host localhost
}

function startdb() {
    compile
    nohup voltdb create catalog ${CATALOG_NAME}.jar \
        license $VOLTDB_HOME/voltdb/license.xml host localhost > /dev/null 2>&1 &
}

function stopdb() {
    voltadmin shutdown
}


function help() {
    echo "Usage: ./run.sh {clean|compile|server|startdb|stopdb|help}"
}

# Run the target passed as the first arg on the command line
# If no first arg, run server
if [ $# -gt 1 ]; then help; exit; fi
if [ $# = 1 ]; then $1; else server; fi
