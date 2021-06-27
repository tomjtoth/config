#
# ~/.bash_profile
#

. ~/.bashrc

#Android related config
if $(uname -a | grep -Pq 'Android'); then
	clear
	export HOSTNAME=$(< ~/.hostname)
	# the below is necessary as the Android storage inhibits chmod +x
	LOCAL=~/.local/bin
	rsync -a ~/soft-hard-ware/linux/bin-private/ $LOCAL
	chmod +x $LOCAL/*.sh
	echo "
	your local IPv4 is: $(ip route get 1 | grep -Po '(?<=src )[\d\.]+')
	"
	. $LOCAL/minden.conf
	if ! $(ps uax | grep -q 'sshd -p '$pSSH'$'); then
		sshd -p $pSSH
	fi
	if ! $(ps uax | grep -q 'nginx: master process nginx$'); then
		nginx
	fi
fi

case $HOSTNAME in
	"15-ab125no")
		export VDPAU_DRIVER=radeonsi
		export LIBVA_DRIVER_NAME=radeonsi
	;;
	
	*)
	export TERM=xterm-256color
	if [ -d "$HOME/.config/..home/.git" ]; then
		cd ~/.config/..home
		git pull
	else
		git clone https://github.com/tomjtoth/config ~/.config/..home
	fi
	;;
esac

#Distro specific config
if [ -f /etc/os-release ]; then
	DISTRO=$(cat /etc/os-release | grep -Poi '^id=\K.+')
	echo "you are running ${DISTRO}, additional measures will be taken later based on this info"
fi

#if it's a headless server
if [ -f /usr/bin/transmission-remote ] ; then
	minden.sh tl
	echo
	df -h
	echo
fi

if [ -z $DISPLAY ] \
&& [[ "$(tty)" =~ \/dev\/tty[1-3] ]] \
&& [ -f /bin/sway ] \
&& [ -f ~/.config/sway/config ]
then
	export PATH
	sway > ~/.sway.log
fi
