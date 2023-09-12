#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd "${SCRIPT_DIR}/../../"

rm -rf "$(pwd)/build/chrome-user-data-dir/${1}"
#rm -rf "$(pwd)/build/sitespeed.io/${1}"

RequestID="abcabc$(date +%s)abcdabcdabcdabcd"

docker run --shm-size=2g --rm \
  -v "$(pwd)/build/sitespeed.io:/sitespeed.io" \
  -v "$(pwd)/config:/config" \
  -v "$(pwd)/build/chrome-user-data-dir/${1}:/tmp/chrome-user-data-dir" \
  -v "./src/javascript/sitespeed.io/lib/plugins/influxdb/senderV2.grafana.net.js:/usr/src/app/lib/plugins/influxdb/senderV2.js" \
  -e MAX_OLD_SPACE_SIZE=3072 \
  sitespeedio/sitespeed.io:29.4.0-plus1 \
  --outputFolder "/sitespeed.io/${1}/${RequestID}" \
  --browsertime.requestheader "x-request-id:$RequestID" \
  --browsertime.requestheader "X-B3-TraceId:$RequestID" \
  --config "/config/desktop/desktop.chrome.json" \
  --lighthouse.config "/config/lighthouse.config.js" \
  --browsertime.iterations 10 \
  --browsertime.retries 1 \
  --maxLoadTime 350000 \
  --browsertime.timeouts.script 300000 \
  --pageCompleteCheck 'return (function() {try { return (malt.stepTimes.get(10013) !== undefined);} catch(e) {} return false;})()' \
  --filmstrip.showAll \
  --pageLoadStrategy "none" \
  --pageCompleteCheckPollTimeout 1000 \
  --pageCompleteCheckStartWait 1000 \
  --pageCompleteWaitTime 350000 \
  --browsertime.cacheClearRaw true \
  --influxdb.tags "db=sitespeed,testtype=firstopen,category=sitespeed_board_test" \
  --urlAlias "${1}" \
  --slug "${1}" \
  "${2}" &> sitespeed.${1}.1.log


RequestID="abcabc$(date +%s)abcdabcdabcdabcd"


docker run --shm-size=2g --rm \
  -v "$(pwd)/build/sitespeed.io:/sitespeed.io" \
  -v "$(pwd)/config:/config" \
  -v "$(pwd)/build/chrome-user-data-dir/${1}:/tmp/chrome-user-data-dir" \
  -v "./src/javascript/sitespeed.io/lib/plugins/influxdb/senderV2.grafana.net.js:/usr/src/app/lib/plugins/influxdb/senderV2.js" \
  -e MAX_OLD_SPACE_SIZE=3072 \
  sitespeedio/sitespeed.io:29.4.0-plus1 \
  --outputFolder "/sitespeed.io/${1}_cache/${RequestID}" \
  --browsertime.requestheader "x-request-id:$RequestID" \
  --browsertime.requestheader "X-B3-TraceId:$RequestID" \
  --config "/config/desktop/desktop.chrome.json" \
  --lighthouse.config "/config/lighthouse.config.js" \
  --browsertime.iterations 10 \
  --browsertime.retries 1 \
  --maxLoadTime 350000 \
  --browsertime.timeouts.script 300000 \
  --pageCompleteCheck 'return (function() {try { return (malt.stepTimes.get(10013) !== undefined);} catch(e) {} return false;})()' \
  --filmstrip.showAll \
  --pageLoadStrategy "none" \
  --pageCompleteCheckPollTimeout 1000 \
  --pageCompleteCheckStartWait 2000 \
  --pageCompleteWaitTime 350000 \
  --influxdb.tags "db=sitespeed,testtype=cache,category=sitespeed_board_test" \
  --urlAlias "${1}" \
  --slug "${1}_cache" \
  "${2}" &> sitespeed.${1}.2.log


cd -

echo $RequestID
