#!/usr/bin/env bash

THEME_PROMPT_HOST='\H'
SCM_THEME_PROMPT_DIRTY=' ✗'
SCM_THEME_PROMPT_CLEAN=' ✓'
SCM_THEME_PROMPT_PREFIX=' |'
SCM_THEME_PROMPT_SUFFIX='|'

SCM_GIT='git'
SCM_GIT_CHAR='±'

SCM_HG='hg'
SCM_HG_CHAR='☿'

SCM_NONE='NONE'
SCM_NONE_CHAR='○'

VIRTUALENV_THEME_PROMPT_PREFIX=' |'
VIRTUALENV_THEME_PROMPT_SUFFIX='|'


function scm {
  if [[ -d .git ]]; then SCM=$SCM_GIT
  elif [[ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]]; then SCM=$SCM_GIT
  elif [[ -d .hg ]]; then SCM=$SCM_HG
  elif [[ -n "$(hg root 2> /dev/null)" ]]; then SCM=$SCM_HG
  else SCM=$SCM_NONE
  fi
}

function scm_prompt_char {
  if [[ -z $SCM ]]; then scm; fi
  if [[ $SCM == $SCM_GIT ]]; then SCM_CHAR=$SCM_GIT_CHAR
  elif [[ $SCM == $SCM_HG ]]; then SCM_CHAR=$SCM_HG_CHAR
  else SCM_CHAR=$SCM_NONE_CHAR
  fi
}

function scm_prompt_vars {
  scm
  scm_prompt_char
  SCM_DIRTY=0
  SCM_STATE=''
  [[ $SCM == $SCM_GIT ]] && git_prompt_vars && return
  [[ $SCM == $SCM_HG ]] && hg_prompt_vars && return
}

function scm_prompt_info {
  scm
  scm_prompt_char
  SCM_DIRTY=0
  SCM_STATE=''
  [[ $SCM == $SCM_GIT ]] && git_prompt_info && return
  [[ $SCM == $SCM_HG ]] && hg_prompt_info && return
}

function git_prompt_vars {
  if [[ -n $(git status -s 2> /dev/null |grep -v ^# |grep -v "working directory clean") ]]; then
    SCM_DIRTY=1
     SCM_STATE=${GIT_THEME_PROMPT_DIRTY:-$SCM_THEME_PROMPT_DIRTY}
  else
    SCM_DIRTY=0
     SCM_STATE=${GIT_THEME_PROMPT_CLEAN:-$SCM_THEME_PROMPT_CLEAN}
  fi
  SCM_PREFIX=${GIT_THEME_PROMPT_PREFIX:-$SCM_THEME_PROMPT_PREFIX}
  SCM_SUFFIX=${GIT_THEME_PROMPT_SUFFIX:-$SCM_THEME_PROMPT_SUFFIX}
  local ref=$(git symbolic-ref HEAD 2> /dev/null)
  SCM_BRANCH=${ref#refs/heads/}
  SCM_CHANGE=$(git rev-parse HEAD 2>/dev/null)
}


function hg_prompt_vars {
    # if [[ -n $(hg status -q 2> /dev/null) ]]; then
    #   SCM_DIRTY=1
    #     SCM_STATE=${HG_THEME_PROMPT_DIRTY:-$SCM_THEME_PROMPT_DIRTY}
    # else
    #   SCM_DIRTY=0
    #     SCM_STATE=${HG_THEME_PROMPT_CLEAN:-$SCM_THEME_PROMPT_CLEAN}
    # fi
	 SCM_STATE=''
    SCM_PREFIX=${HG_THEME_PROMPT_PREFIX:-$SCM_THEME_PROMPT_PREFIX}
    SCM_SUFFIX=${HG_THEME_PROMPT_SUFFIX:-$SCM_THEME_PROMPT_SUFFIX}
	 # Call hg summary once since it is a little slow and cache the result to process with awk
    # TMP_SUMMARY=$(hg summary 2> /dev/null)
	 # SCM_BRANCH=$(echo $TMP_SUMMARY | awk -F"branch: " '{print $2}' | awk '{print $1}')
	 # SCM_CHANGE=$(echo $TMP_SUMMARY | awk -F"parent: " '{print $2}' | awk '{print $1}')
	 if [ -f ".hg/branch" ];
	 then SCM_BRANCH=$(cat .hg/branch); 
	 else SCM_BRANCH='default';
	 fi
    # SCM_BRANCH=$(hg summary 2> /dev/null | grep branch | awk '{print $2}')
    # SCM_CHANGE=$(hg summary 2> /dev/null | grep parent | awk '{print $2}')
}




# function virtualenv_prompt {
#   if which virtualenv &> /dev/null; then
#     virtualenv=$([ ! -z "$VIRTUAL_ENV" ] && echo "`basename $VIRTUAL_ENV`") || return
#     echo -e "$VIRTUALENV_THEME_PROMPT_PREFIX$virtualenv$VIRTUALENV_THEME_PROMPT_SUFFIX"
#   fi
# }

# backwards-compatibility
function git_prompt_info {
  git_prompt_vars
  echo -e "$SCM_PREFIX$SCM_BRANCH$SCM_STATE$SCM_SUFFIX"
}


function hg_prompt_info() {
  hg_prompt_vars
  echo -e "$SCM_PREFIX$SCM_BRANCH:${SCM_CHANGE#*:}$SCM_STATE$SCM_SUFFIX"
}

function scm_char {
  scm_prompt_char
  echo -e "$SCM_CHAR"
}

function prompt_char {
    scm_char
}
