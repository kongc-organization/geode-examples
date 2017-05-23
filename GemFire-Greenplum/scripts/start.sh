#!/bin/bash
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e

current=`pwd`
scriptpath=`dirname $0`
cd `dirname $0`

. ./setEnv.sh

cd $current



gfsh  start locator --name=locator --bind-address=127.0.0.1 --include-system-classpath --cache-xml-file=./scripts/server-cache.xml

gfsh start server --name=server1 --locators=127.0.0.1[10334] --server-port=0 --include-system-classpath --classpath=../build/classes/main --cache-xml-file=./scripts/server-cache.xml

gfsh start server --name=server2 --locators=127.0.0.1[10334] --server-port=0 --include-system-classpath --classpath=../build/classes/main --cache-xml-file=./scripts/server-cache.xml

# create a region using GFSH
gfsh -e "connect --locator=localhost[10334]" -e "list members"

gfsh -e "connect --locator=localhost[10334]" -e "list regions"

exit 0