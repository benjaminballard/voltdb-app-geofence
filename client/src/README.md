README for client package
=========================

This java client source is based on the VoltDB example application "voter", specifically the AsyncBenchmark, but refactored to separate boilerplate from application-specific code.

BaseBenchmark.java: 
  - boilerplate
  - should not need to be modified
  - establishes connection, collects statistics, prints periodic stats, drives the main loops of the benchmark
  
BenchmarkCallback.java
  - a general-purpose callback class for tracking the results of asynchronous stored-procedure calls.  
  - Keeps a thread-safe count of invocations, commits, and rollbacks
  - provides a summary report
  
BenchmarkConfig.java
  - defines the commmand-line arguments for the benchmark
  
GeoFenceBenchmark.java
  - extends BaseBenchmark.java
  - uses command-line arguments from BenchmarkConfig.java
  - Provides the implementation for application-specific actions:
     initialize() - executed once, pre-populates devices
     iterate()
         - executed at a controlled rate throughout the duration of the benchmark
         - picks a random device and moves it randomly to a new location a few miles from the previous position
         - stored procedure in database will record this new position and detect entry/exit events
     printResults() - customized to list the results of the particular stored procedures involved.

DeviceSimulator.java
  - called by GeoFenceBenchmark.java
  - loadZipcodes: loads zipcodes from a file
  - initializeDevices: generates data for devices using the zipcodes as potential "home" locations
  - randomMovement: generates data for random movement of a device
