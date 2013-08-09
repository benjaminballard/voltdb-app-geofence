#!/usr/bin/env bash

. ./env.sh

SERVERS=volt3a,volt3b,volt3c

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
        --warmup=1 \
        --duration=10 \
        --servers=localhost:21212 \
        --autotune=false \
        --ratelimit=100000
}

function testsim() {
    java -classpath obj:$CLASSPATH -Dlog4j.configuration=file://$LOG4J \
        client.DeviceSimulator data/Gaz_zcta_national.txt

}

function test20000() {
    srccompile
    # run client
    java -classpath obj:$CLASSPATH:obj -Dlog4j.configuration=file://$LOG4J \
        client.TrainBenchmark \
        --displayinterval=5 \
        --warmup=5 \
        --duration=120 \
        --servers=$SERVERS \
        --ratelimit=20000 \
        --autotune=true \
        --latencytarget=1 \
        --filename=data/1-20000.txt
}

function test1_1() {
    srccompile
    # run client
    java -classpath obj:$CLASSPATH:obj -Dlog4j.configuration=file://$LOG4J \
	client.TrainBenchmark \
        --displayinterval=5 \
        --warmup=5 \
        --duration=30 \
        --servers=$SERVERS \
        --ratelimit=100000 \
        --autotune=false \
        --latencytarget=1 \
        --filename=data/1_1.txt \
		--request=1.1
}

function test1_1_BIG() {
    srccompile
    # run client
    java -classpath obj:$CLASSPATH:obj -Dlog4j.configuration=file://$LOG4J \
        client.TrainBenchmark \
        --displayinterval=5 \
        --warmup=5 \
        --duration=30 \
        --servers=$SERVERS \
        --ratelimit=200000 \
        --autotune=false \
        --latencytarget=1 \
        --filename=data/1_1_BIG.txt \
                --request=1.1
}
function test1_1_BIG_ALT() {
    srccompile
    # run client
    java -classpath obj:$CLASSPATH:obj -Dlog4j.configuration=file://$LOG4J \
        client.TrainBenchmark \
        --displayinterval=5 \
        --warmup=5 \
        --duration=30 \
        --servers=$SERVERS \
        --ratelimit=200000 \
        --autotune=false \
        --latencytarget=1 \
        --filename=data/1_1_BIG.txt \
        --request=1.1 \
        --alttest=true
}


function test1_1_SMALL() {
    srccompile
    # run client
    java -classpath obj:$CLASSPATH:obj -Dlog4j.configuration=file://$LOG4J \
        client.TrainBenchmark \
        --displayinterval=5 \
        --warmup=5 \
        --duration=30 \
        --servers=$SERVERS \
        --ratelimit=200000 \
        --autotune=false \
        --latencytarget=1 \
        --filename=data/1_1_SMALL.txt \
                --request=1.1
}


function test1_4() {
    srccompile
    # run client
    java -classpath obj:$CLASSPATH:obj -Dlog4j.configuration=file://$LOG4J \
	client.TrainBenchmark \
        --displayinterval=5 \
        --warmup=5 \
        --duration=30 \
        --servers=$SERVERS \
        --ratelimit=200000 \
        --autotune=false \
        --latencytarget=1 \
        --filename=data/1_4.txt \
		--request=1.4
}

function test1_5() {
    srccompile
    # run client
    java -classpath obj:$CLASSPATH:obj -Dlog4j.configuration=file://$LOG4J \
	client.TrainBenchmark \
        --displayinterval=5 \
        --warmup=5 \
        --duration=30 \
        --servers=$SERVERS \
        --ratelimit=200000 \
        --autotune=false \
        --latencytarget=1 \
        --filename=data/1_5.txt \
		--request=1.5
}

function test1_6() {
    srccompile
    # run client
    java -classpath obj:$CLASSPATH:obj -Dlog4j.configuration=file://$LOG4J \
	client.TrainBenchmark \
        --displayinterval=5 \
        --warmup=5 \
        --duration=30 \
        --servers=$SERVERS \
        --ratelimit=200000 \
        --autotune=false \
        --latencytarget=1 \
        --filename=data/1_6.txt \
		--request=1.6
}

function test1_8() {
    srccompile
    # run client
    java -classpath obj:$CLASSPATH:obj -Dlog4j.configuration=file://$LOG4J \
	client.TrainBenchmark \
        --displayinterval=5 \
        --warmup=5 \
        --duration=30 \
        --servers=$SERVERS \
        --ratelimit=200000 \
        --autotune=false \
        --latencytarget=1 \
        --filename=data/1_8.txt \
		--request=1.8
}

function test2_6() {
    srccompile
    # run client
    java -classpath obj:$CLASSPATH:obj -Dlog4j.configuration=file://$LOG4J \
	client.TrainBenchmark \
        --displayinterval=5 \
        --warmup=5 \
        --duration=30 \
        --servers=$SERVERS \
        --ratelimit=200000 \
        --autotune=false \
        --latencytarget=1 \
        --filename=data/2_6.txt \
		--request=2.6
}

function test2_9() {
    srccompile
    # run client
    java -classpath obj:$CLASSPATH:obj -Dlog4j.configuration=file://$LOG4J \
	client.TrainBenchmark \
        --displayinterval=5 \
        --warmup=5 \
        --duration=30 \
        --servers=$SERVERS \
        --ratelimit=200000 \
        --autotune=false \
        --latencytarget=1 \
        --filename=data/2_9.txt \
		--request=2.9
}

function test3_1() {
    srccompile
    # run client
    java -classpath obj:$CLASSPATH:obj -Dlog4j.configuration=file://$LOG4J \
	client.TrainBenchmark \
        --displayinterval=5 \
        --warmup=5 \
        --duration=100000 \
        --servers=$SERVERS \
        --ratelimit=200000 \
        --autotune=false \
        --latencytarget=1 \
        --filename=data/3_1.txt \
		--request=3.1
}

function loader() {
    srccompile
    java -Xmx512m -Dfile.encoding=UTF-8 -classpath obj:$CLASSPATH:lib/mysql-connector-java-5.1.24-bin.jar \
        -Dlog4j.configuration=file://$LOG4J \
        client.MySqlLoader
}

function help() {
    echo "Usage: ./run.sh {clean|client|help|srccompile}"
}

# Run the target passed as the first arg on the command line
# If no first arg, run server
if [ $# -gt 1 ]; then help; exit; fi
if [ $# = 1 ]; then $1; else client; fi
