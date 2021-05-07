## 工具



### 官方镜像包

```bash
docker pull ghcr.io/chia-network/chia:latest
```

文档：https://github.com/orgs/Chia-Network/packages/container/package/chia



#### 官方dockerfile:

https://github.com/Chia-Network/chia-docker



### 校验是否同步

```bash
docker exec -it chia venv/bin/chia show -s -c
```

注：同步较慢，需要等待约5分钟才有信息。（可按提示添加同步节点，加快同步，如：docker exec -it chia venv/bin/chia show -a 14.3.203.42:8444）

​		整体同步完成12小时+（来自服务器47.118.62.219的测试数据）