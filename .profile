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

if [ -d ~/.config/.tomjtoth ]; then
	if [ -d "$HOME/.config/.tomjtoth/.git" ]; then
		cd ~/.config/..home
		git pull
	else
		git clone https://github.com/tomjtoth/config ~/.config/.tomjtoth
	fi
fi

