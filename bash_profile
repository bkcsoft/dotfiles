hncol=$(hostname | od | tr ' ' '\n' | awk '{total = total + $1}END{print 30 + (total % 6)}')
uncol=$(whoami | od | tr ' ' '\n' | awk '{total = total + $1}END{print 30 + (total % 5)}')

function _git_prompt() {
	local git_status="$(git status -unormal 2>&1)"
	if ! [[ "$git_status" =~ "Not a git repo" ]]; then
		if [[ "$git_status" =~ "nothing to commit" ]]; then
			local ansi=32
		elif [[ "$git_status" =~ "nothing added to commit but untracked files present" ]]; then
			local ansi=34
		elif [[ "$git_status" =~ "fatal: This operation must be run in a work tree" ]]; then
			local ansi=37
		else
			local ansi=33
		fi
		alias __git_ps1='git branch 2>/dev/null | grep "*" | sed "s/* \(.*\)/\1/"'
		alias __git_mod='git status -s 2>/dev/null | wc -l'
		echo -n ""
		PS1="\[\e[1;32m\][\[\e[0;32m\]pwd: \[\e[1;34m\]\w\[\e[1;32m\]] \[\e[0;${ansi}m\]($(__git_ps1) $(__git_mod))\[\e[0m\]\n[\[\e[0;${uncol}m\]\u\e[m\]@\e[1;${hncol}m\]\h\[\e[1;32m\]] \$\[\e[m\] "
	else
		PS1='\[\e[1;32m\][\[\e[0;32m\]pwd: \[\e[1;34m\]\w\[\e[1;32m\]]\n[\[\e[0;${uncol}m\]\u\e[m\]@\e[1;${hncol}m\]\h\[\e[1;32m\]] \$\[\e[m\] '
	fi
}


PROMPT_COMMAND=_git_prompt
#PS1='\[\e[1;32m\][\[\e[0;32m\]pwd: \[\e[1;34m\]\w\[\e[1;32m\]] `_git_prompt`\n[\[\e[0;32m\]\u\e[m\]@\e[1;31m\]\h\[\e[1;32m\]] \$\[\e[m\] '

#tty | grep "/dev/ttyv"
#if [ $? -eq 0 ]; then
#	MODE=$(vidcontrol -i mode | awk '/1280x1024x32/ {print $1}')
#	vidcontrol MODE_$MODE
#fi

#shopt -s globstar

export EDITOR="vim"
export PATH="$HOME/sources/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/sources/lib:$LD_LIBRARY_PATH"
export ABSROOT="$HOME/abs"
export BROWSER="chromium"

alias pacman='pacapt'

alias sysinfo='sysctl dev.cpu.0.freq dev.asmc.0.{fan,temp}'
if [ "$(uname -s)" == "Linux" ]; then
	alias ls='ls --color=auto -lhF'
else
	alias ls='ls  -GlhF'
fi
alias grep='grep --color'
#alias mocpnp='mocp -Q "%artist - %song  (%album)" 2> /dev/null'
#alias hextemp='TMPFILE=$(mktemp hextemp.XXX) && hexedit $TMPFILE && rm $TMPFILE'
if which systemctl >/dev/null 2>&1; then
	alias scstart='sudo systemctl start'
	alias scstop='sudo systemctl stop'
	alias scstatus='sudo systemctl status'
	alias scenable='sudo systemctl enable'
	alias scdisable='sudo systemctl disable'
fi

#alias mplayer='systemd-inhibit --what=handle-lid-switch --who=mplayer mplayer'
#alias nosleep='systemd-inhibit --what=handle-lid-switch --who=sleep sleep'
#alias timer='systemd-inhibit --what=handle-lid-switch --who=timer --why="what do you think idiot" $HOME/sources/bin/timer'

if which unclutter >/dev/null 2>&1; then
	alias unclutter='unclutter -idle 3 -jitter 150 -grab'
fi

export BASHPROFILELOADED='true'

GPG_TTY="$(tty)"

if which mplayer && which youtube-dl; then
	function yt () {
		mplayer -fs -quiet -cache 2048 $(youtube-dl -g "$1")
	}
fi
