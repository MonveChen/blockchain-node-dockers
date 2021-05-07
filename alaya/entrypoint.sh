
cd ~/platon-node/

if [[ ${network} == "test" ]]; then
  echo "当前：测试网络" 
  if [[ -f "/usr/bin/platon_testnet" ]]; then
    echo "/usr/bin/platon_testnet -> /usr/bin/platon"
    mv /usr/bin/platon /usr/bin/platon_mainnet
    mv /usr/bin/platon_testnet /usr/bin/platon
    echo "/usr/bin/alayakey_testnet -> /usr/bin/alayakey"
    mv /usr/bin/alayakey /usr/bin/alayakey_mainnet
    mv /usr/bin/alayakey_testnet /usr/bin/alayakey
  fi
  docker_name="alaya_testnet"
  if [[ -f "./data/nodeid" ]]; then
    if [[ ! -d "./data/platon" ]]; then
      echo "初始化创世区块" 
      platon --datadir ./data init genesis.json
    fi
    platon --identity alaya-node --datadir ./data --port 16789 --alaya --rpcport 6789 --rpcapi "db,platon,net,web3,admin,personal" --rpc --nodekey ./data/nodekey --cbft.blskey ./data/blskey --verbosity 1 --rpcaddr 0.0.0.0 --bootnodes enode://48f9ebd7559b7849f80e00d89d87fb92604c74a541a7d76fcef9f2bcc67043042dfab0cfbaeb5386f921208ed9192c403f438934a0a39f4cad53c55d8272e5fb@devnetnode1.alaya.network:16789 --syncmode "fast"
  fi
else
  docker_name="alaya"
  if [[ ${network} == 'main' ]] && [[ -f "./data/nodeid" ]]; then
    echo "当前：主网络" 
    platon --identity alaya-node --datadir ./data --port 16789 --alaya --rpcport 6789 --rpcapi 'db,platon,net,web3,admin,personal' --rpc --nodekey ./data/nodekey --cbft.blskey ./data/blskey --verbosity 1 --rpcaddr 0.0.0.0 --syncmode 'fast'
  fi
fi

if [[ ${network} == 'produce' ]]; then
  echo "状态：生产环境"
fi

if [[ ! -f "./data/nodeid" ]] && [[ ${network} != 'produce' ]]; then
  echo "未创建节点秘钥，无法正常启动，请按如下操作准备节点所需："
  echo "1.vim docker-compose.yml，设置生产环境：network=produce"
  echo "2.重启容器：docker-compose up -d"
  echo "3.进入生产环境：docker exec -it ${docker_name} /bin/bash"
  echo "4.生成节点秘钥文件：mkdir -p ~/platon-node/data && (alayakey genkeypair | tee >(grep \"PrivateKey\" | awk '{print \$2}' > ~/platon-node/data/nodekey) >(grep \"PublicKey\" | awk '{print \$3}' > ~/platon-node/data/nodeid)) && (alayakey genblskeypair | tee >(grep \"PrivateKey\" | awk '{print \$2}' > ~/platon-node/data/blskey) >(grep \"PublicKey\" | awk '{print \$3}' > ~/platon-node/data/blspub))"
  echo "5(可选).生成质押钱包：mtool-client account new staking"
  echo "6(可选).生成收益钱包：mtool-client account new reward"
  echo "7.退出生产环境：exit"
  echo "8.vim docker-compose.yml，改回环境：network=${network}"
  echo "9.重启容器：docker-compose up -d ，即可"
elif [[ ! -f "./data/nodeid" ]] && [[ ${network} == 'produce' ]]; then
  echo "1.进入生产环境：docker exec -it ${docker_name} /bin/bash"
  echo "2.生成节点秘钥文件：mkdir -p ~/platon-node/data && (alayakey genkeypair | tee >(grep \"PrivateKey\" | awk '{print \$2}' > ~/platon-node/data/nodekey) >(grep \"PublicKey\" | awk '{print \$3}' > ~/platon-node/data/nodeid)) && (alayakey genblskeypair | tee >(grep \"PrivateKey\" | awk '{print \$2}' > ~/platon-node/data/blskey) >(grep \"PublicKey\" | awk '{print \$3}' > ~/platon-node/data/blspub))"
  echo "3(可选).生成质押钱包：mtool-client account new staking"
  echo "4(可选).生成收益钱包：mtool-client account new reward"
  echo "5.退出生产环境：exit"
  echo "6.vim docker-compose.yml，改回环境：network=main"
  echo "7.重启容器：docker-compose up -d ，即可"
fi

if [[ ${network} == 'produce' ]]; then
  exec /sbin/init
fi
