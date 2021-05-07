## 使用方法



### 一、拉取镜像

```bash
docker image pull monve/platon:latest && docker tag monve/platon:latest platon:latest && docker rmi monve/platon:latest
```

###### 或 构建镜像

```bash
docker build -t platon:latest .
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



### 三、成为验证节点（当追上主网块高时发起）

#### 1.进入platon容器

```bash
docker exec -it platon /bin/bash
```

#### 2.配置验证节点信息

```bash
cd $PLATON_MTOOLDIR && ./validator_conf.sh
```

### 3.发起质押操作

##### 参数说明请查看官网教程：https://devdocs.platon.network/docs/zh-CN/Become_PlatON_Main_Verification/

发起**示例**（鲸交所）：

```bash
platon_mtool staking --config $PLATON_MTOOLDIR/validator/validator_config.json --keystore $PLATON_MTOOLDIR/keystore/staking.json --autoamount 110000 --benefit_address lat1qg8n6fyj8hmglm8dtm8uhlhtz5x8dr2unzp3cz --delegated_reward_rate 5000 --node_name WhaleEx --website w.whaleex.com.cn --details '#1 Decentralized Exchange in the World' --external_id 649C15C6152A6398
```

示例详情：https://devnetscan.platon.network/node-detail?address=0xb9ab0cbe96ef2d36303bed53bca00d949ac8720c188b978bf30171b51efad8db9dedaa0cdedc5490e985da0275d89d56696bd5d2eb01997af21c2b2229974a61

#### 4.退出platon容器

```bash
exit
```





## 其他工具

### 一、进入`PlatON`控制台

```bash
docker exec -it platon /bin/platon attach http://localhost:6789
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

开发网：https://devnetscan.platon.network/
