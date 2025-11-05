# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Put your fun stuff here.

PATH="${HOME}/bin${PATH:+:${PATH}}"; export PATH;

shopt -s extglob

if which starship > /dev/null 2>&1; then
  eval "$(starship init bash)"
fi

if which mcfly > /dev/null 2>&1; then

  export MCFLY_FUZZY
  MCFLY_FUZZY=2
  eval "$(mcfly init bash)"

fi

if which zoxide > /dev/null 2>&1; then
  eval "$(zoxide init --cmd cd bash)"
fi

alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias emacs="emacsclient -c -a '' &"
alias datas="source ~/bin/datas.sh"
alias prog="source ~/bin/prog.sh"
alias rc="~/bin/rc.sh"

vifm()
{
  vifm="$HOME/bin/vifm"

  dir=$($vifm --choose-dir - "$@")

  if [ -n "$dir" ] && [ -d "$dir" ]; then
    cd "$dir"
  fi
}
