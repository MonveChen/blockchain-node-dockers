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



#### 转账激活地址

解锁

```bash
account unlock
```

转账

```bash
account transfer -v 1000000000 -r <转入地址> -k <公钥> -b
```

