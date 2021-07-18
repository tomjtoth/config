#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $DISPLAY ]] && shopt -s checkwinsize

PS1='[\u@\h \W]\$ '

case ${TERM} in
	xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
		PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
		;;
	screen*)
		PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
		;;
esac

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

#tomjtoth

[[ "$PATH" != */.local/bin* ]] && PATH="$HOME/.local/bin:$PATH"

. ~/.bash_aliases

[ -f ~/.user_pass ] && cat ~/.user_pass

GITHUB=~/.config/.tomjtoth
if [ -d $GITHUB ]; then
	LAST=.last_github_sync
	if [ ! -f $GITHUB/$LAST ] \
	|| [ $(<$GITHUB/$LAST) -lt $(($(date +%s)-60*60*24)) ]; then
		echo -e "\n\tupdating config files\n"
		git -C $GITHUB stash
		git -C $GITHUB pull
		echo
		date +%s > $GITHUB/$LAST
		. ~/.bash_aliases
	fi
fi

