#tomjtoth

<<OFF
if [ $HOSTNAME != "15-ab125no" ]; then
	#Touchpad
	synclient TapButton1=1
	synclient TapButton2=2
	synclient TapButton3=3
	synclient TouchpadOff=0
fi
OFF

if [ -f ~/.sync_github_configs ]; then
	if [ -d "$HOME/.config/..home/.git" ]; then
		cd ~/.config/..home
		git pull
	else
		git clone https://github.com/tomjtoth/config ~/.config/..home
	fi
fi

