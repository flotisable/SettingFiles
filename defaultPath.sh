#!/bin/sh

configProgram=$1
os=$2

case ${configProgram} in

  mpv   )

    case ${os} in

      Linux       ) echo "${HOME}/.config/mpv";;
      Windows_NT  ) echo "${APPDATA}\\mpv";;
      Darwin      ) echo "${HOME}/.config/mpv";;

    esac;;

  mpsyt )

    case ${os} in

      Linux       ) echo "${HOME}/.config/mps-youtube";;
      Windows_NT  ) echo "${APPDATA}\\mps-youtube";;
      Darwin      ) echo "${HOME}/.config/mps-youtube";;

    esac;;

esac
