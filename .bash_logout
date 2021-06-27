#tomjtoth

if $(uname -a | grep -Pq 'Android') \
&& [ $(tty) = "/dev/pts/0" ]
then
	pkill nginx
	pkill sshd
fi

