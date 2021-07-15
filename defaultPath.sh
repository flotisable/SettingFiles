#!/bin/sh

configProgram=$1
os=$2

case ${configProgram} in

  mutt              ) echo "${HOME}/.muttrc";;
  git               ) echo "${HOME}/.gitconfig";;
  top               ) echo "${HOME}/.toprc";;
  tmux              ) echo "${HOME}/.tmux.conf";;
  screen            ) echo "${HOME}/.screenrc";;
  starship          ) echo "${HOME}/.config/starship.toml";;
  efmLanguageServer ) echo "${HOME}/.config/efm-langserver/config.yaml";;

  mpv       )

    case ${os} in

      Linux       ) echo "${HOME}/.config/mpv";;
      Windows_NT  ) echo "${APPDATA}\\mpv";;
      Darwin      ) echo "${HOME}/.config/mpv";;

    esac;;

  mpsyt     )

    case ${os} in

      Linux       ) echo "${HOME}/.config/mps-youtube";;
      Windows_NT  ) echo "${APPDATA}\\mps-youtube";;
      Darwin      ) echo "${HOME}/.config/mps-youtube";;

    esac;;

esac
