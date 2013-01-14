#!/usr/bin/env bash

function __ {
  echo "$@"
}

function __make_ansi {
  next=$1 && shift
  echo "\[\e[$(__$next $@)m\]"
}

# function __make_echo {
#   next=$1 && shift
#   echo "\033[$(__$next $@)m"
# }


function __reset {
  next=$1 && shift
  out="$(__$next $@)"
  echo "0${out:+;${out}}"
}

function __bold {
  next=$1 && shift
  out="$(__$next $@)"
  echo "${out:+${out};}1"
}

# function __faint {
#   next=$1 && shift
#   out="$(__$next $@)"
#   echo "${out:+${out};}2"
# }
# 
# function __italic {
#   next=$1 && shift
#   out="$(__$next $@)"
#   echo "${out:+${out};}3"
# }

# function __underline {
#   next=$1 && shift
#   out="$(__$next $@)"
#   echo "${out:+${out};}4"
# }
# 
# function __negative {
#   next=$1 && shift
#   out="$(__$next $@)"
#   echo "${out:+${out};}7"
# }
# 
# function __crossed {
#   next=$1 && shift
#   out="$(__$next $@)"
#   echo "${out:+${out};}8"
# }


function __color_normal_fg {
  echo "3$1"
}
# 
# function __color_normal_bg {
#   echo "4$1"
# }
# 
# function __color_bright_fg {
#   echo "9$1"
# }
# 
# function __color_bright_bg {
#   echo "10$1"
# }


# function __color_black   {
#   echo "0"
# }

function __color_red   {
  echo "1"
}

function __color_green   {
  echo "2"
}

# function __color_yellow  {
#   echo "3"
# }

# function __color_blue  {
#   echo "4"
# }

function __color_magenta {
  echo "5"
}

function __color_cyan  {
  echo "6"
}

# function __color_white   {
#   echo "7"
# }

# function __color_rgb {
#   r=$1 && g=$2 && b=$3
#   [[ r == g && g == b ]] && echo $(( $r / 11 + 232 )) && return # gray range above 232
#   echo "8;5;$(( ($r * 36  + $b * 6 + $g) / 51 + 16 ))"
# }

function __color {
  color=$1 && shift
  case "$1" in
    fg|bg) side="$1" && shift ;;
    *) side=fg;;
  esac
  case "$1" in
    normal|bright) mode="$1" && shift;;
    *) mode=normal;;
  esac
  [[ $color == "rgb" ]] && rgb="$1 $2 $3" && shift 3

  next=$1 && shift
  out="$(__$next $@)"
  echo "$(__color_${mode}_${side} $(__color_${color} $rgb))${out:+;${out}}"
}


# function __black   {
#   echo "$(__color black $@)"
# }

function __red   {
  echo "$(__color red $@)"
}

function __green   {
  echo "$(__color green $@)"
}

# function __yellow  {
#   echo "$(__color yellow $@)"
# }

# function __blue  {
#   echo "$(__color blue $@)"
# }

function __magenta {
  echo "$(__color magenta $@)"
}

function __cyan  {
  echo "$(__color cyan $@)"
}

# function __white   {
#   echo "$(__color white $@)"
# }

# function __rgb {
#   echo "$(__color rgb $@)"
# }


function __color_parse {
  next=$1 && shift
  echo "$(__$next $@)"
}

function color {
  echo "$(__color_parse make_ansi $@)"
}

# function echo_color {
#   echo "$(__color_parse make_echo $@)"
# }


# black="$(color reset black)"
red="$(color reset red)"
green="$(color reset green)"
# yellow="$(color reset yellow)"
# blue="$(color reset blue)"
purple="$(color reset magenta)"
# cyan="$(color reset cyan)"
# white="$(color reset white bold)"
# orange="$(color reset red fg bright)"

# bold_black="$(color black bold)"
# bold_red="$(color red bold)"
bold_green="$(color green bold)"
# bold_yellow="$(color yellow bold)"
# bold_blue="$(color blue bold)"
# bold_purple="$(color magenta bold)"
bold_cyan="$(color cyan bold)"
# bold_white="$(color white bold)"
# bold_orange="$(color red fg bright bold)"

# underline_black="$(color black underline)"
# underline_red="$(color red underline)"
# underline_green="$(color green underline)"
# underline_yellow="$(color yellow underline)"
# underline_blue="$(color blue underline)"
# underline_purple="$(color magenta underline)"
# underline_cyan="$(color cyan underline)"
# underline_white="$(color white underline)"
# underline_orange="$(color red fg bright underline)"
# 
# background_black="$(color black bg)"
# background_red="$(color red bg)"
# background_green="$(color green bg)"
# background_yellow="$(color yellow bg)"
# background_blue="$(color blue bg)"
# background_purple="$(color magenta bg)"
# background_cyan="$(color cyan bg)"
# background_white="$(color white bg bold)"
# background_orange="$(color red bg bright)"

# normal="$(color reset)"
reset_color="$(__make_ansi '' 39)"

