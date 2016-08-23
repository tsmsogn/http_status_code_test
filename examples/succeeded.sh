#!/bin/sh

cd $(dirname $0)
base=$(pwd)

succeeded=0
failed=0

for url_status in \
    "http://httpstat.us/200 200" \
    "http://httpstat.us/404 404" \
    "http://httpstat.us/410 410" \
    "http://httpstat.us/300 300"
do
    url=`echo $url_status | cut -f1 -d" "`
    status=`echo $url_status | cut -f2 -d" "`

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
