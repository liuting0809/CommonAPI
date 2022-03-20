#!/bin/bash

rm -r build

./../commonapi_core_generator/commonapi-core-generator-linux-x86_64 -sk ./fidl/*.fidl -dest src-gen/core
./../commonapi_someip_generator/commonapi-someip-generator-linux-x86_64 fidl/*.fdepl -dest src-gen/someip

mkdir build
cd build

cmake .. -DCMAKE_PREFIX_PATH=$1  
make
cp lib* $1/lib

touch "startClient.sh"
echo "export LD_LIBRARY_PATH=$1/lib" >> startClient.sh
echo "export VSOMEIP_APPLICATION_NAME=client-sample"  >> startClient.sh
echo "export VSOMEIP_CONFIGURATION=vsomeip-local.json"  >> startClient.sh
echo "export COMMONAPI_CONFIG=../commonapi4someip.ini"  >> startClient.sh
echo "./E01HelloWorldClient" >> startClient.sh

chmod 775 startClient.sh

touch "startService.sh"
echo "export LD_LIBRARY_PATH=$1/lib" >> startService.sh
echo "export VSOMEIP_APPLICATION_NAME=service-sample" >> startService.sh
echo "export VSOMEIP_CONFIGURATION=vsomeip-local.json" >> startService.sh
echo "export COMMONAPI_CONFIG=../commonapi4someip.ini" >> startService.sh
echo "./E01HelloWorldService" >> startService.sh

chmod 775 startService.sh