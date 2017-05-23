<!--
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements.  See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to You under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License.  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->

# GemFire-Greenplum connector with partitioned region example

This example demonstrates how to transfer data between GemFire and Greenplum via Pivotal connector.  

The basic GemFire/Geode property of partitioning is that data entries are distributed across all
servers that host a region.  The distribution is like database sharding, except
that the distribution occurs automatically. 

In this example, two GemFire/Geode servers host a single partitioned region.  There is no
redundancy, so that the basic property of partitioning may be observed.  The
example puts 10 entries into the region and prints them.  Because the region is
partitioned, its entries are distributed among the two servers hosting the
region.  Since there is no redundancy of the data within the region, when one
of the servers goes away, the entries hosted within that server are also gone;
the example demonstrates this.

This example also uses a Greenplum cluster with two segment nodes. The GemFire-Greenplum connector can parallelize the data transfer between GemFire and Greenplum. Therefore, it provides a high speed data throughput, compared to data transfer via a typical JDBC connector. 



# Assumptions
* This example assumes that Java and Geode/GemFire are installed. 

* You will need to download GemFire-Greenplum connector from https://network.pivotal.io/products/pivotal-gemfire.  The gemfire-greenplum-3.0.0.jar should be copied to ```geode-examples/GemFire-Greenplum/```

* This example assumes you have docker-compose preinstalled


## Demonstration of GemFire-Greenplum connector
1. Set directory ```geode-examples/GemFire-Greenplum``` to be the
current working directory.
Each step in this example specifies paths relative to that directory.
1. Run the docker-compose to download and run Geode/GemFire and GPDB docker images
```
        $ docker-compose up
        Starting geodeexamples_gemfire_1
        Starting geodeexamples_gpdb_1
        ...
```

2. Run this command to access the Geode/GemFire docker image 
```
     $ docker exec -it geodeexamples_gemfire_1 bash 
```

3. Change your directory to ```/code/GemFire-Greenplum``` and run this command to set environment variables
```
        $ cd /code/GemFire-Greenplum
```
      

4. Run this script to create tables in GPDB database.
```

        $ scripts/setupDB.sh
        psql:./sample_table.sql:1: NOTICE:  table "basic" does not exist, skipping
        DROP TABLE
        CREATE TABLE
        INSERT 0 1
        INSERT 0 1
        ...
        INSERT 0 1
        INSERT 0 1
```


5. Download GemFire-Greenplum connector jar. Place the file (gemfire-greenplum-3.0.0.jar) under ```geode-examples/GemFire-Greenplum```. If you are using a different file version, make sure you change the script ```geode-examples/GemFire-Greenplum/scripts/setEnv.sh``` 


5. Run a script that starts a locator and two servers.  Each of the servers
hosts the partitioned region.  The gemfire-greenplum-3.0.0.jar will be placed onto the
classpath when the script starts the servers. Also, you can verify the "basic" and "basic2" regions are created.

```     
        $ scripts/start.sh 
        ...
        ...
        Executing - list regions

        List of regions
        ---------------
        basic
        basic2
        example-region
        ..

```

6. **Import data** into `basic` region. The data
will also be transfer from the Greenplum table into GemFire region.

 ```       
            $ scripts/importdata.sh
            ....
            (2) Executing - import gpdb --region=/basic

            GemFire entries imported : 5
            Duration                 : 4.55s
            ...

 ```

7. Run a `gfsh` command to see the contents of the region
```

        $ gfsh -e "connect --locator=localhost[10334]" -e "query --query=\"select id.toString() as id, col1, col2 from /basic\""

        ...
        Result     : true
        startCount : 0
        endCount   : 20
        Rows       : 5

        id |  col1  | col2
        ...
```

   

8. **Export data** from `basic` region (GemFire) to table (Greenplum).

 ```       
            $ scripts/exportdata.sh
            ....
            (2) Executing - export gpdb --region=/basic --type=UPSERT

            GemFire entries exported : 5
            Greenplum rows updated   : 5
            Greenplum rows inserted  : 0
            Duration                 : 0.96s
            ...

 ```



7. Shut down the cluster
```

        $ scripts/stop.sh
```

