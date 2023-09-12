import { InfluxDB, Point, HttpError } from '@influxdata/influxdb-client';

export class InfluxDB2Sender {
    constructor({ protocol, host, port, database, organisation, token }) {
        this.client = new InfluxDB({
            url: `${protocol}://${host}:${port}`,
            headers: {"Authorization": `Bearer ${token}`},
            proxyUrl: "http://host.docker.internal:9090",
            writeOptions: {
                batchSize: 1000,
                flushInterval: 1000,
                maxBufferLines: 1000000000,
                maxRetries: 10,
                maxRetryTime: 30000,

                exponentialBase: 0,
                maxRetryDelay: 5000,
                minRetryDelay: 5000,
                randomRetry: true,
                retryJitter: 500
            }
        }).getWriteApi(organisation, database);
        this.client.path = "/api/v1/push/influx/write";
    }

    send(data) {
        const points = [];
        for (let point of data) {
            const influxPoint = new Point(point.seriesName);
            for (const key of Object.keys(point.tags)) {
                influxPoint.tag(key, point.tags[key]);
            }
            for (const key of Object.keys(point.point)) {
                if (key === 'time') {
                    influxPoint.timestamp(new Date(point.point[key]));
                } else {
                    influxPoint.floatField(key, point.point[key]);
                }
            }
            points.push(influxPoint);
        }
        this.client.writePoints(points);

        return this.client.flush().catch(error => {
            if (error instanceof HttpError && error.statusCode === 401) {
                throw new Error(
                    `The InfluxDB database: ${this.database} doesn't exist.`
                );
            } else if (error instanceof HttpError && error.statusCode === 429) {
                throw new Error(
                    `Grafana.net limit: ${error.message}.`
                );
            }
            throw new Error('Writing to influx failed');
        });
    }
}