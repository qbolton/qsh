for i in $(/usr/bin/ls $HOME/qsh2/env)
do 
read resp?"Update ${i}? "
if [ ${resp} = "y" ]
then
	cp $HOME/qsh/env/${i} $HOME/qsh2/env/${i}
fi
done
