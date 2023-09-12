# sitespeed.automation
An example of test automation with the sitespeed.io framework

## src/javascript/sitespeed.io/lib/plugins/influxdb/

### senderV2.default.js
Default InfluxDB sender v2.
- Source: https://github.com/sitespeedio/sitespeed.io/blob/main/lib/plugins/influxdb/senderV2.js
- Docs: https://www.sitespeed.io/documentation/sitespeed.io/configuration/#the-options

### senderV2.grafana.net.js

Custom InfluxDB sender v2 for Grafana.net HTTP Metric Sender.

```bash
--influxdb.protocol https
--influxdb.host influx-prod-13-prod-us-east-0.grafana.net
--influxdb.port 443
--influxdb.token 111111111:2222222222222222222222==
--influxdb.version 2
```
