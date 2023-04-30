# 监控服务

## 监控架构

- 监控可视化：grafana
- 监控数据库：influxdb【Todos】
- 监控数据收集组件：prometheus
  - 具备本地存储
- 监控采集组件
  - 主机监控：Node Exporter
  - 数据库监控【Todos】

## 运行方式

```bash
docker-compose -f docker-compose-grafana.yml up -d
docker-compose -f docker-compose-prometheus.yml up -d
```
