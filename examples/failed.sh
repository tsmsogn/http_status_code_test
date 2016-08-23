#!/bin/sh

cd $(dirname $0)
base=$(pwd)

succeeded=0
failed=0

for url_status in \
    "" \
    "invalid_status http://httpstat.us/200"
do
    status=`echo $url_status | cut -f1 -d" "`
    url=`echo $url_status | cut -f2 -d" "`

    $base/../http_status_code_test.sh $url --status $status --debug

    case $? in
        0)
            succeeded=`expr $succeeded + 1`
            ;;
        *)
            failed=`expr $failed + 1`
            ;;
    esac
done

echo "succeeded: $succeeded, failed: $failed"
