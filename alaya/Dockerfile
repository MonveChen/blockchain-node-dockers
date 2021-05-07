#基础镜像
FROM ubuntu

WORKDIR /root
#维护者信息
LABEL maintainer="164598724@qq.com"

EXPOSE 16789 6789
#镜像的操作指令
RUN apt-get update \
	&& apt-get install wget --assume-yes \
	&& apt-get install sudo \
	&& apt-get install unzip \
	&& sudo apt-get install -y gnupg2 curl software-properties-common ntp 

#主网用文件
RUN sudo wget https://download.alaya.network/alaya/platon/0.15.0/platon -P /usr/bin  \
	&& sudo wget https://download.alaya.network/alaya/platon/0.15.0/alayakey -P /usr/bin \
	&& sudo chmod +x /usr/bin/platon  /usr/bin/alayakey

#开发网用文件
RUN sudo wget https://download.alaya.network/alaya/platon/0.15.1/platon -O /usr/bin/platon_testnet  \
	&& sudo wget https://download.alaya.network/alaya/platon/0.15.1/alayakey -O /usr/bin/alayakey_testnet \
	&& sudo chmod +x /usr/bin/platon_testnet  /usr/bin/alayakey_testnet

RUN mkdir -p ~/platon-node/data

#预下载创世区块文件，测试网使用
RUN cd ~/platon-node && wget https://download.alaya.network/alaya/platon/0.15.1/genesis.json

#MTool工具包
RUN cd ~ \
	&& wget http://download.alaya.network/alaya/mtool/linux/0.15.0/mtool-client.zip \
	&& unzip mtool-client.zip \
	&& cd mtool-client \
	&& wget https://download.alaya.network/alaya/scripts/mtool_install.sh \
	&& chmod +x mtool_install.sh && ./mtool_install.sh
RUN /bin/bash -c 'source ~/.bashrc'
ENV JAVA_HOME /ro]ot/jdk1.8.0_221
ENV JRE_HOME $JAVA_HOME/jre
ENV CLASS_PATH .:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib
ENV PATH $PATH:$JAVA_HOME/bin:$JRE_HOME/bin
ENV ALAYA_MTOOLDIR /root/mtool-client

#准备好质押预准备
RUN cd $ALAYA_MTOOLDIR \
	&& wget https://download.alaya.network/alaya/scripts/validator_conf.sh \
	&& chmod +x validator_conf.sh

ADD ./entrypoint.sh entrypoint.sh
#容器启动时的执行命令
# ENTRYPOINT [ "/bin/bash", "-c" ]
ENTRYPOINT ["bash", "./entrypoint.sh"]
#主网
# CMD [ "cd ~/platon-node/ && nohup platon --identity alaya-node --datadir ./data --port 16789 --alaya --rpcport 6789 --rpcapi 'db,platon,net,web3,admin,personal' --rpc --nodekey ./data/nodekey --cbft.blskey ./data/blskey --verbosity 1 --rpcaddr 0.0.0.0 --syncmode 'fast'"]
