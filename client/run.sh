#!/usr/bin/env bash

. ./env.sh

SERVERS=localhost

# remove build artifacts
function clean() {
    rm -rf obj log stocks
}

# compile the source code for procedures and the client
function srccompile() {
    mkdir -p obj
    javac -classpath $CLASSPATH -d obj -Xlint:deprecation \
        src/*.java
    # stop if compilation fails
    if [ $? != 0 ]; then exit; fi
}

# run the client that drives the example
function client() {
    srccompile
    java -classpath obj:$CLASSPATH -Dlog4j.configuration=file://$LOG4J \
        client.GeoFenceBenchmark \
        --displayinterval=5 \
        --warmup=3 \
        --duration=30 \
        --servers=$SERVERS \
        --autotune=true \
        --ratelimit=100000
}

function testsim() {
    java -classpath obj:$CLASSPATH -Dlog4j.configuration=file://$LOG4J \
        client.DeviceSimulator data/Gaz_zcta_national.txt

}

function help() {
    echo "Usage: ./run.sh {clean|client|help|srccompile}"
}

# Run the target passed as the first arg on the command line
# If no first arg, run server
if [ $# -gt 1 ]; then help; exit; fi
if [ $# = 1 ]; then $1; else client; fi
