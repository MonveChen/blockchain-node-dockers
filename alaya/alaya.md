## 使用方法



### 一、拉取镜像

```bash
docker image pull monve/alaya:latest && docker tag monve/alaya:latest alaya:latest && docker rmi monve/alaya:latest
```

###### 或 构建镜像

```bash
docker build -t alaya:latest .
```



### 二、运行

#### 使用docker-compose启动

```bash
docker-compose up -d
```

#### 查看docker日志

```bash
docker logs alaya
```

并按日志指示操作

#### 

### 三、成为验证节点（当追上主网块高时发起）

#### 1.进入platon容器

```bash
docker exec -it alaya /bin/bash
```

#### 2.配置验证节点信息

```bash
cd $ALAYA_MTOOLDIR && ./validator_conf.sh
```

### 3.发起质押操作

##### 参数说明请查看官网教程：https://devdocs.alaya.network/alaya-devdocs/zh-CN/Become_Verification_Node/

官方**示例**（参数请按实际情况配置）：

```bash
mtool-client staking --config $MTOOLDIR/validator/validator_config.json --keystore $MTOOLDIR/keystore/staking.json --amount 10000 --benefit_address xxx196278ns22j23awdfj9f2d4vz0pedld8a2fzwwj --delegated_reward_rate 5000 --node_name myNode --website www.mywebsite.com --details myNodeDescription --external_id 121412312
```

#### 4.退出platon容器

```bash
exit
```





## 其他工具

### 一、进入`PlatON`控制台

```bash
docker exec -it alaya /bin/platon attach http://localhost:6789
```

#### 查看节点的 peers

```bash
admin.peers
```

#### 查看当前块高

```bash
platon.blockNumber
```

如果是新节点，块高一直为0时，则表示节点在同步区块，可能会存在延迟，可通过命令：

```bash
platon.syncing
```

- 如果打印`false`，表示节点未处于同步区块状态；

- 如果打印如下信息，表示节点正处于同步区块状态；

  ```json
  {
    currentBlock: 1412416,
    highestBlock: 1416699,
    knownStates: 522,
    pulledStates: 522,
    startingBlock: 1408247
  }
  ```

##### 退出命令

```bash
exit
```



### 二、PlatON 区块链浏览器

主网：https://scan.platon.network/

开发网：https://devnetscan.alaya.network
