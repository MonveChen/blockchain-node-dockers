## 工具



### 官方镜像包

```bash
docker pull starcoin/starcoin:latest
```

文档：https://developer.starcoin.org/zh/setup/run_by_docker/



### 校验是否同步

#### 进入控制台

```bash
docker exec -it starcoin /starcoin/starcoin --connect ~/.starcoin/main/starcoin.ipc console
```

#### 查询进度

```bash
node sync progress
```

