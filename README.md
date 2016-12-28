# hadoop_automated_deployment
deploy hadoop automatically and simply by using shell scripts
操作系统:	ubuntu-16.04-server-amd64
默认用户:	hadoop	(password:hadoop)
必需程序:	openssh-server, expect
Jdk版本:	1.8.0_101
JAVA_HOME:	/usr/local/java/jdk1.8.0_101

Hadoop版本:	Apache hadoop 2.7.2
HADOOP_HOME:	/home/hadoop/hadoop-2.7.2
scala版本：	2.12.0
SCALA_HOME:	/home/hadoop/scala-2.12.0
Spark版本：spark-1.6.1-bin-hadoop2.6
SPARK_HOME:	/home/hadoop/spark-1.6.1

自动化部署脚本目录:	/home/hadoop/automatedDeployment

自动化部署脚本的主要功能：根据配置自动改变节点的（在/etc目录下）hostname和hosts，自动从master向所有slave节点分发配置好的hadoop文件，实现ssh的无密码登录。
自动化部署hadoop步骤：
	1)	启动所有需要使用节点的虚拟机并使用默认用户登录（如果改变用户或密码，需要相应修改自动化部署脚本中的用户参数）。
	2)	在master节点上，根据用户需求配置hadoop(或使用默认设置)。
	3)	在master节点上配置/home/hadoop/automatedDeployment目录下的hosts文件和/home/hadoop/hadoop-2.7.2/etc/hadoop目录下的slaves文件。hosts文件内容是所有节点机器的ip地址和hostname，格式是每一行为ip+空白符+hostname。slaves文件内容是所有slave节点的hostname。
	4)	在master节点上执行/home/hadoop/automatedDeployment目录下的mastermain.sh脚本，等待完成部署。


# reference
http://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/ClusterSetup.html
http://www.powerxing.com/install-hadoop-cluster/

