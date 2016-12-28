#!/bin/bash
#################################
export FILELOC=/home/hadoop
# export allFile=$FILELOC/auto_hadoop.tar.gz
export HADOOP_HOME=$FILELOC/hadoop-2.7.2
export SPARK_HOME=$FILELOC/spark-1.6.1
export SCALA_HOME=$FILELOC/scala-2.12.0
export autofileLoc=$FILELOC/automatedDeployment
export sshLoc=$FILELOC/.ssh
export HOSTSFILE=$autofileLoc/hosts
export hadoop_etc_dir=$HADOOP_HOME/etc
export spark_conf_dir=$SPARK_HOME/conf
export user=hadoop
export password=hadoop
export local_hostname=`hostname`
export local_ip=`/sbin/ifconfig | sed -n '/inet addr/s/^[^:]*:\([0-9.]\{7,15\}\).*/\1/p' | grep -v 127`
#################################

# now the user has configured the hadoop #

# first, package all files to auto_hadoop.tar.gz #
# echo "packaging the files, waiting..."
# tar -zcf $allFile -C $FILELOC hadoop-2.7.2 automatedDeployment
cd $autofileLoc

echo local_hostname is $local_hostname
echo local_ip is $local_ip
##
cat $HOSTSFILE | while read host
do
	chr=($host)
	ipAddress=${chr[0]}
	hostname=${chr[1]}
	if [ $ipAddress == $local_ip ]
	then
	# master ##
		echo $hostname\($ipAddress\) is a master
		./hostnameChanger.exp $password $hostname $local_hostname $local_ip
		./hostsChanger.exp $HOSTSFILE $password
		./sshkey_gen.exp
		./sshkey_authorise.sh $sshLoc/id_rsa.pub $sshLoc/authorized_keys
		./sshTest.exp $user $hostname $password
		echo "--------------end master-------------"
	# end master ##	
	else
	# slave ##

		echo $hostname\($ipAddress\) is a slave
	#copy all files from master to slave
		./scpFile.exp $hadoop_etc_dir $user $ipAddress $HADOOP_HOME $password
		./scpFile.exp $spark_conf_dir $user $ipAddress $SPARK_HOME $password
		./scpFile.exp $sshLoc/id_rsa.pub $user $ipAddress $FILELOC $password
		./scpFile.exp $autofileLoc/hosts $user $ipAddress $autofileLoc $password
		./sshLogin.exp $user $hostname $password
	# end slave ##
	fi
	
done
cd -
