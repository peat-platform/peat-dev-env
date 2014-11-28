#!/usr/bin/env bash


stats () {
    indices=$(curl -s -XGET "http://localhost:9200/_cat/indices?" | awk '{print $2}' | sort)
    numIndices=$(curl -s -XGET "http://localhost:9200/_cat/indices?" | wc -l)
    buckets=$(sudo /opt/couchbase/bin/couchbase-cli bucket-list -c 127.0.0.1:8091 -u admin -p password | sed -e '/:/d' | sort)
    numBuckets=$(sudo /opt/couchbase/bin/couchbase-cli bucket-list -c 127.0.0.1:8091 -u admin -p password | sed -e '/:/d' | wc -l)
}

output () {
    echo Elasticsearch Indices: [${numIndices}] ${indices}
    echo Couchbase Buckets: [${numBuckets}] ${buckets}
}

createBucket () {
    echo Creating Bucket: ${index}
    bucketResult=$(sudo /opt/couchbase/bin/couchbase-cli bucket-create --wait -c 127.0.0.1:8091 --bucket=${index} --bucket-type=couchbase --bucket-ramsize=100 --bucket-replica=0 -u admin -p password)
    if [[ ${bucketResult} == *SUCCESS* ]]; then
        echo Bucket created successfully
    fi
}

createIndex () {
    echo Creating Index: ${index}
    indexResult=$(curl -s -XPUT "http://localhost:9200/${index}" -d '{"index":{"analysis":{"analyzer":{"default":{"type":"whitespace","tokenizer":"whitespace"}}}}}')
    if [[ ${indexResult} == *true* ]]; then
        echo Index created successfully
    fi
}

createReplication () {
    echo Creating Replication
    xdcrResult=$(sudo /opt/couchbase/bin/couchbase-cli xdcr-replicate --wait -c 127.0.0.1:8091 -u admin -p password  --xdcr-cluster-name elasticsearch --xdcr-from-bucket ${index} --xdcr-to-bucket ${index} --xdcr-replication-mode capi)
    if [[ ${xdcrResult} == *SUCCESS* ]]; then
        echo Replication created successfully
    fi
}


deleteBucket () {
    echo Deleting Bucket: ${index}
    bucketResult=$(sudo /opt/couchbase/bin/couchbase-cli bucket-delete --wait -c 127.0.0.1:8091 --bucket=${index} --bucket-type=couchbase --bucket-ramsize=100 --bucket-replica=0 -u admin -p password)
    if [[ ${bucketResult} == *SUCCESS* ]]; then
        echo Bucket deleted successfully
    fi
}

deleteIndex () {
    echo Deleting Index: ${index}
    indexResult=$(curl -s -XDELETE "http://localhost:9200/${index}")
    if [[ ${indexResult} == *true* ]]; then
        echo Index deleted successfully
    fi
}

deleteReplication () {
    replicator=$(sudo /opt/couchbase/bin/couchbase-cli xdcr-replicate --wait -c 127.0.0.1:8091 --list -u admin -p password | sed -n 1p | awk '{print $3}' | sed 's/\/.*//')
    replicatorID=${replicator}/${index}/${index}
    xdcrResult=$(sudo /opt/couchbase/bin/couchbase-cli xdcr-replicate --wait -c 127.0.0.1:8091 --delete --xdcr-replicator=${replicatorID}  -u admin -p password)
    echo Deleting Replication
    if [[ ${xdcrResult} == *SUCCESS* ]]; then
        echo Replication deleted successfully
    fi
}

startCouch () {
    sudo /etc/init.d/couchbase-server start

    until [[ $(curl -w %{http_code} -s --output /dev/null  -u admin:password http://localhost:8091/pools) == 200 ]]; do
        sleep 5
    done
    status
}

stopCouch () {
    sudo /etc/init.d/couchbase-server stop
}

startElastic () {
    cbStatus=$(curl -w %{http_code} -s --output /dev/null  -u admin:password http://localhost:8091/pools)
    wait
    sudo service elasticsearch start

    until [[ $(curl -w %{http_code} -s --output /dev/null 'http://localhost:9200/_cluster/health?pretty=true') == 200 ]]; do
        sleep 5
    done

    if [[ ${cbStatus} == 000 ]]; then
        startCouch
    fi

    status
}

stopElastic () {
    sudo service elasticsearch stop
}

help () {
    usage="$(basename "$0") [-h] [-l] [-c name] [-d name] [-b backupDir] [-r backupDir bucket] [-s] -- monitor & configure Elasticsearch-Couchbase Replication\n\n
    where:\n
    -h  show this help text \n
    -l  list current indices and buckets \n
    -c  create index, bucket, and replication \n
    -d  delete index, bucket, and replication \n
    -b  backup cluster \n
    -r  restore bucket \n
    -s  stop elasticsearch & couchbase \n
    "
    echo -e ${usage}
    exit 0
}

status () {
    cbStatus=$(curl -w %{http_code} -s --output /dev/null  -u admin:password http://localhost:8091/pools)
    esStatus=$(curl -w %{http_code} -s --output /dev/null 'http://localhost:9200/_cluster/health?pretty=true')
    wait

    if [[ ${esStatus} == 000  &&  ${cbStatus} == 000 ]]; then
        echo Neither Elasticsearch nor Couchbase are running
        echo "Do you want to start them?"
        select yn in "Yes" "No"; do
            case ${yn} in
                Yes ) startElastic;;
                No ) exit;;
            esac
        done
    fi

    if [[ ${esStatus} == 000 ]]; then
        echo Elasticsearch is not running
        echo "Do you want to start it?"
        select yn in "Yes" "No"; do
            case ${yn} in
                Yes ) startElastic;;
                No ) exit;;
            esac
        done
    fi

    if [[ ${cbStatus} == 000 ]]; then
        echo Couchbase is not running
        echo "Do you want to start it?"
        select yn in "Yes" "No"; do
            case ${yn} in
                Yes ) startCouch;;
                No ) exit;;
            esac
        done
    fi

    if [[ ${esStatus} == 200  &&  ${cbStatus} == 200 ]]; then
        stats
        output
        exit 0
    fi
}


if [ "$1" == "-l" ]; then
    status
fi


if [ "$1" == "-c" ]; then
    if [[ $# -lt 2 ]]; then
        help
    elif [[ $# -eq 2 ]]; then
        stats
        index=$2
        if [[ ${indices} == *${index}* ]]; then
            echo Index exists
        else
            createIndex
            createBucket
            createReplication
        fi
    fi
fi


if [ "$1" == "-d" ]; then
    if [[ $# -lt 2 ]]; then
        help
    elif [[ $# -eq 2 ]]; then
        stats
        index=$2
        if [[ ${indices} != *${index}* ]]; then
            echo Index does not exist
        else
            deleteReplication
            deleteIndex
            deleteBucket
        fi
    fi
fi


if [ "$1" == "-b" ]; then
    path=$2
    echo Backing up cluster to ${path}
    sudo /opt/couchbase/bin/cbbackup http://127.0.0.1:8091 ${path} -u admin -p password
fi


if [ "$1" == "-r" ]; then
    path=$2
    bucket=$3
    echo Restoring ${bucket} from ${path}
    sudo /opt/couchbase/bin/cbrestore ${path} --bucket-source=${bucket} http://127.0.0.1:8091 -u admin -p password
fi


if [[ "$1" == "-h" || $# -lt 1 ]]; then
    help
fi

if [ "$1" == "-s" ]; then
    stopCouch
    stopElastic
fi