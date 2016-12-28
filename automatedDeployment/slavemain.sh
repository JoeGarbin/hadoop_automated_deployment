#!/bin/bash
#################################
export FILELOC=/home/hadoop
export allFile=$FILELOC/auto_hadoop.tar.gz
export HADOOP_HOME=$FILELOC/hadoop-2.7.2
export autofileLoc=$FILELOC/automatedDeployment
export sshLoc=$FILELOC/.ssh
export master_sshLoc=$FILELOC
export HOSTSFILE=$autofileLoc/hosts
export user=hadoop
export password=hadoop
export local_hostname=`hostname`
export local_ip=`/sbin/ifconfig | sed -n '/inet addr/s/^[^:]*:\([0-9.]\{7,15\}\).*/\1/p' | grep -v 127`
#################################

# first, unpackage auto_hadoop.tar.gz #
# echo "unpackaging the files, waiting..."
# tar -zxf $allFile -C $FILELOC



###
cd $autofileLoc
echo local_hostname is $local_hostname
echo local_ip is $local_ip
host=`cat $HOSTSFILE | grep $local_ip`
echo host is  $host
chr=($host)
ipAddress=${chr[0]}
hostname=${chr[1]}
echo "change $local_hostname to  $hostname"
./hostnameChanger.exp $password $hostname $local_hostname $local_ip
./hostsChanger.exp $HOSTSFILE $password
./sshkey_gen.exp
./sshkey_authorise.sh $sshLoc/id_rsa.pub $sshLoc/authorized_keys
./sshkey_authorise.sh $FILELOC/id_rsa.pub $sshLoc/authorized_keys
rm $FILELOC/id_rsa.pub
./sshTest.exp $user $hostname $password
cd -

