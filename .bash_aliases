#tomjtoth


AUR="pacaur"
AUR_conf=~/.config/pacaur/config
[ ! -f $AUR_conf ] && \
	mkdir -p ${AUR_conf%/*} && \
	echo "editor=nano" > $AUR_conf
KEEP_PKG_NUMBER=0


if [ -f /usr/bin/pacman ]; then

INSTALL="f() {
	[ \$(( (\$(date +%s) - \
		\$(stat -c %Y /var/lib/pacman/sync/*.db \
		| sort | tail -n 1))/60/60 )) -ge 24 ] && sudo pacman -Syy
	unset -f f
}
f && $AUR -S"
REMOVE="sudo pacman -Rscn"
SEARCH="pacman -Ss"
SEARCH_AUR="$AUR -Ss"
INFO="$AUR -Si"
LIST="pacman -Ql"
UPDATE="sudo pacman -Syyu --noconfirm && sudo paccache -k $KEEP_PKG_NUMBER -r"
UPDATER="$UPDATE && systemctl -i reboot"
UPDATEP="$UPDATE && systemctl -i poweroff"
FIX="sudo pacman-key --refresh-keys"
INSTALL_ASDEP="sudo pacman -U --asdeps"
THROTTLEU="sudo wondershaper wlo1 -u"
THROTTLED="sudo wondershaper wlo1 -d"
THROTTLEC="sudo wondershaper clear wlo1"

elif [ -f /usr/bin/apt ]; then

INSTALL="sudo apt update && sudo apt install"
REMOVE="sudo apt-get purge"
SEARCH="apt-cache search"
INFO="apt show"
LIST="dpkg-query -L"
UPDATE="sudo apt update && sudo apt upgrade"
UPDATER="$UPDATE && systemctl -i reboot"
THROTTLEU="sudo wondershaper eth0 -u"
THROTTLED="sudo wondershaper eth0 -d"
THROTTLEC="sudo wondershaper clear eth0"

elif [ -f /data/data/com.termux/files/usr/bin/pkg ]; then

INSTALL="pkg install"
REMOVE="pkg uninstall"
SEARCH="pkg search"
LIST="pkg files"
UPDATE="pkg upgrade"

fi


alias {éé,öö}="$INSTALL"
alias {éá,öä}="$SEARCH"
alias éáű="$SEARCH_AUR"
alias {é,ö}r="$REMOVE"
alias {ééé,ööö}="$UPDATE"
alias {ééé,ööö}r="$UPDATE && reboot"
alias {ééé,ööö}p="$UPDATE && poweroff"
alias {ééé,ööö}z="$UPDATE && zzz"
alias {é,ö}fix="$FIX"
alias {é,ö}i="$INFO"
alias {é,ö}l="$LIST"
alias {é,ö}u="$INSTALL_ASDEP"
alias {é,ö}s="sudo -E -s"
alias {é,ö}d="d() {
	bg
	disown -h %$1
	unset -f d
}
d"
alias {é,ö}tu="$THROTTLEU"
alias {é,ö}td="$THROTTLED"
alias {é,ö}tc="$THROTTLEC"
alias tt="echo -e \"\ncurrently active transfers:\n\"; ps axu | grep -Po 'sender.+(torrents|\/data\/download)\/\K.+(?=\")'; echo"
alias tl="minden.sh tl opzp"
alias tg="minden.sh tg opzp"
alias td="minden.sh td opzp"


# etc


alias zzz="z() {
	[ -n \"\$1\" ] && \
		echo \"going to suspend in \$1\" && \
		sleep \$1
	systemctl -i suspend
	unset -f z
}
z"
alias rtop1="sudo radeontop -b 0:1"
alias rprof="sudo radeon-profile"
alias ntop="sudo nethogs"
alias mmnt='manual_mounter() {
	if [[ "$@" == *-u* ]]; then
		sudo umount ~/mnt
	else
		[ ! -d ~/mnt ] && mkdir ~/mnt
		sudo mount -o ro,loop "$1"  ~/mnt
	fi
	unset -f manual_mounter
}
manual_mounter'
alias youtube-mp3="youtube-dl -x --audio-format mp3"
alias youtube-best="youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4'"
alias sss="sudo systemctl"
alias doom_sw="gzdoom ~/downloads/Xim-StarWars-v2.8.2/Xim-StarWars-v2.8.2.pk3"
alias win32="WINEARCH=win32 WINEPREFIX=~/.wine32bit wine"
