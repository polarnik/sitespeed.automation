module.exports = {
    "extends": "lighthouse:default",
    "settings": {
        "maxWaitForFcp": 60000,
        "maxWaitForLoad": 350000,
        "formFactor": "desktop",
        "throttling": {
            "rttMs": 40,
            "throughputKbps": 10240,
            "cpuSlowdownMultiplier": 1,
            "requestLatencyMs": 0,
            "downloadThroughputKbps": 0,
            "uploadThroughputKbps": 0
        },
        "screenEmulation": {
            "mobile": false,
            "width": 1350,
            "height": 940,
            "deviceScaleFactor": 1,
            "disabled": false
        },
        "emulatedUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.5845.96  crawler/1.0",
        "skipAudits": [
        ]
    }
};