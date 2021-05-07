#基础镜像
FROM ubuntu

WORKDIR /root
#维护者信息
LABEL maintainer="164598724@qq.com"
#节点 P2P 端口，默认为16789; rpc端口，默认为 6789
EXPOSE 16789 6789
#镜像的操作指令
RUN apt-get update \
	&& apt-get install wget --assume-yes \
	&& apt-get install sudo \
	&& apt-get install unzip \
	&& sudo apt-get install -y gnupg2 curl software-properties-common ntp 

RUN sudo wget https://download.platon.network/platon/platon/1.0.0/platon -P /usr/bin    
RUN sudo wget https://download.platon.network/platon/platon/1.0.0/platonkey -P /usr/bin

RUN sudo chmod +x /usr/bin/platon  /usr/bin/platonkey

RUN mkdir -p ~/platon-node/data

RUN cd ~/platon-node && wget https://download.platon.network/platon/devnet/platon/1.0.0/genesis.json

#MTool工具包
RUN cd ~ \
	&& wget https://download.platon.network/platon/mtool/linux/1.0.0/platon_mtool.zip \
	&& unzip platon_mtool.zip \
	&& cd platon_mtool \
	&& wget https://download.platon.network/platon/scripts/mtool_install.sh \
	&& chmod +x mtool_install.sh && ./mtool_install.sh
RUN /bin/bash -c 'source ~/.bashrc'
ENV JAVA_HOME /root/jdk1.8.0_221
ENV JRE_HOME $JAVA_HOME/jre
ENV CLASS_PATH .:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib
ENV PATH $PATH:$JAVA_HOME/bin:$JRE_HOME/bin
ENV PLATON_MTOOLDIR /root/platon_mtool

#准备好质押预操作
RUN cd $PLATON_MTOOLDIR \
	&& wget https://download.platon.network/platon/scripts/validator_conf.sh \
	&& chmod +x validator_conf.sh 

ADD ./entrypoint.sh entrypoint.sh
ENTRYPOINT ["bash", "./entrypoint.sh"]
