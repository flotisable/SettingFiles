#!/bin/sh

configProgram=$1
os=$2

case ${configProgram} in

  mpv   )

    case ${os} in

      linux   ) echo "${HOME}/.config/mpv";;
      windows ) echo "${APPDATA}\\mpv";;
      macos   ) echo "${HOME}/.config/mpv";;

    esac;;

  mpsyt )

    case ${os} in

      linux   ) echo "${HOME}/.config/mps-youtube";;
      windows ) echo "${APPDATA}\\mps-youtube";;
      macos   ) echo "${HOME}/.config/mps-youtube";;

    esac;;

esac
