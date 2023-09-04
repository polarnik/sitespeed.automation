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
  -e MAX_OLD_SPACE_SIZE=3072 \
  sitespeedio/sitespeed.io:29.4.0-plus1 \
  --outputFolder "/sitespeed.io/${1}/${RequestID}" \
  --browsertime.requestheader "x-request-id:$RequestID" \
  --browsertime.requestheader "X-B3-TraceId:$RequestID" \
  --config "/config/desktop/desktop.chrome.json" \
  --lighthouse.config "/config/lighthouse.config.js" \
  --browsertime.iterations 1 \
  --browsertime.retries 1 \
  --maxLoadTime 350000 \
  --browsertime.timeouts.script 300000 \
  --pageCompleteCheck 'return (function() {try { return (malt.stepTimes.get(10013) !== undefined);} catch(e) {} return false;})()' \
  --filmstrip.showAll \
  --pageLoadStrategy "none" \
  --pageCompleteCheckPollTimeout 1000 \
  --pageCompleteCheckStartWait 1000 \
  --pageCompleteWaitTime 350000 \
  --verbose \
  --urlAlias "${1}" \
  --slug "${1}" \
  "${2}"


RequestID="abcabc$(date +%s)abcdabcdabcdabcd"


docker run --shm-size=2g --rm \
  -v "$(pwd)/build/sitespeed.io:/sitespeed.io" \
  -v "$(pwd)/config:/config" \
  -v "$(pwd)/build/chrome-user-data-dir/${1}:/tmp/chrome-user-data-dir" \
  -e MAX_OLD_SPACE_SIZE=3072 \
  sitespeedio/sitespeed.io:29.4.0-plus1 \
  --outputFolder "/sitespeed.io/${1}/${RequestID}" \
  --browsertime.requestheader "x-request-id:$RequestID" \
  --browsertime.requestheader "X-B3-TraceId:$RequestID" \
  --config "/config/desktop/desktop.chrome.json" \
  --lighthouse.config "/config/lighthouse.config.js" \
  --browsertime.iterations 1 \
  --browsertime.retries 1 \
  --maxLoadTime 350000 \
  --browsertime.timeouts.script 300000 \
  --pageCompleteCheck 'return (function() {try { return (malt.stepTimes.get(10013) !== undefined);} catch(e) {} return false;})()' \
  --filmstrip.showAll \
  --pageLoadStrategy "none" \
  --pageCompleteCheckPollTimeout 1000 \
  --pageCompleteCheckStartWait 2000 \
  --pageCompleteWaitTime 350000 \
  --verbose \
  --multi \
  --urlAlias "${1}_cache" \
  --slug "${1}_cache" \
  "${2}"


cd -

echo $RequestID
