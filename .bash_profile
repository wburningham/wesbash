#!/usr/bin/env bash

PATH=$PATH:/usr/local/mysql/bin

# Don't check mail when opening terminal.
unset MAILCHECK


# ----- BEGIN COLORS -----
# Load colors
	source "$HOME/.wesbash/colors.theme.bash"
	source "$HOME/.wesbash/base.theme.bash"
	# colored grep
	export GREP_OPTIONS='--color=auto'
	export GREP_COLOR='1;33'

	export LSCOLORS='Gxfxcxdxdxegedabagacad'

	source "$HOME/.wesbash/bobby.theme.bash"
# ----- END COLORS -----



# ----- BEGIN ALIASES -----
	source "$HOME/.wesbash/general.aliases.bash"
	source "$HOME/.wesbash/git.aliases.bash"
	# source "$HOME/.wesbash/git.plugins.bash"
	alias reload='source ~/.bash_profile'
# ----- END ALIASES -----


# ----- BEGIN HISTORY -----
	# append to bash_history if Terminal.app quits
	shopt -s histappend
	# Erase duplicates
	export HISTCONTROL="ignoredups"
	# resize history size
	export HISTSIZE=5000
# ----- END HISTORY -----

