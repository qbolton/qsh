set -x
typeset sPath=$1
#typeset sIP=$2

if (( $# != 1 ))
then
	print "_qsh2cfg.ksh <path> <ip>"
	print "NO IP address, NO install/update."
	return 1
fi

clear;

if [ -d ${sPath}/qsh/qsh2 ]
then
	rm -fr ${sPath}/qsh/qsh2
	rm -f ${sPath}/qsh2_install
fi

if [ ! -d ${sPath}/qsh ]
then
	print "QSH2 Compact Installation in $HOME"
	print "==================================="

	sIP=$DISPLAY
	cp -r /prod/users/capdev/u90659/qsh2 ${sPath}/qsh
	print ". ~/qsh/env/init.env" >> ${sPath}/.profile

	ln -s ${sPath}/qsh/dat/.update ${sPath}/.update

	print "name=${LOGNAME}|size=4|${sIP}|1" >  ${sPath}/qsh/dat/acl.dat

	print "==================================="
	print "Finished QSH2 Compact Installation"
else
	print "QSH2 Compact Update in $HOME"
	print "==================================="

	sIP=$(cat ${sPath}/qsh/dat/acl.dat | cut -d'|' -f3)
	mv ${sPath}/qsh ${sPath}/qsh.bak
	cp -r /prod/users/capdev/u90659/qsh2 ${sPath}/qsh
	print "name=${LOGNAME}|size=4|${sIP}|1" >  ${sPath}/qsh/dat/acl.dat
	rm -r ${HOME}/qsh.bak

	print "==================================="
	print "Finished QSH2 Compact Update"
fi

set +x

chmod 775 ${sPath}/qsh
chmod 775 ${sPath}/qsh/dat
chmod 775 ${sPath}/qsh/dat/*
chmod 775 ${sPath}/qsh/bin
chmod 775 ${sPath}/qsh/bin/*
chmod 775 ${sPath}/qsh/env
chmod 775 ${sPath}/qsh/env/*
chmod 775 ${sPath}/qsh/inc
chmod 775 ${sPath}/qsh/inc/*
chmod 775 ${sPath}/qsh/log
chmod 775 ${sPath}/qsh/log/*
chmod 775 ${sPath}/qsh/opt
chmod 775 ${sPath}/qsh/opt/*
