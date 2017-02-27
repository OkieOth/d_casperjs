#!/bin/bash

scriptPos=${0%/*}


source "$scriptPos/image_conf.sh"

if [ -z $TEST_SCRIPT_DIR ]; then
    echo "need a env variable TEST_SCRIPT_DIR that points to dir with tests to run - cancel"
    exit 1
fi

if ! [ -d "$TEST_SCRIPT_DIR" ]; then
    echo "TEST_SCRIPT_DIR doesn't point to a directory - cancel"
    echo "TEST_SCRIPT_DIR=$TEST_SCRIPT_DIR"
    exit 1
fi

testScriptDir=`pushd "$TEST_SCRIPT_DIR" > /dev/null && pwd && popd > /dev/null`

aktImgName=`docker images |  grep -G "$imageBase *$imageTag *" | awk '{print $1":"$2}'`

if [ "$aktImgName" == "$imageBase:$imageTag" ]
then
        echo "run container from image: $aktImgName"
else
	if docker build -t $imageName $scriptPos/../image
    then
        echo -en "\033[1;34mImage created: $imageName \033[0m\n"
    else
        echo -en "\033[1;31mError while create image: $imageName \033[0m\n"
        exit 1
    fi
fi

#    docker run --rm --entrypoint /bin/bash -it --name "$contName" -v ${testScriptDir}:/opt/myproject "$imageBase:$imageTag" 
    docker run --rm -v ${testScriptDir}:/opt/myTests "$imageBase:$imageTag" 


