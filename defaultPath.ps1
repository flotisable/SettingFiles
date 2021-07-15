Param(
  $configProgram,
  $os
)

Switch( ${configProgram} )
{
  mutt              { "${env:USERPROFILE}/.muttrc"                            }
  git               { "${env:USERPROFILE}/.gitconfig"                         }
  top               { "${env:USERPROFILE}/.toprc"                             }
  tmux              { "${env:USERPROFILE}/.tmux.conf"                         }
  screen            { "${env:USERPROFILE}/.screenrc"                          }
  starship          { "${env:USERPROFILE}/.config/starship.toml"              }
  efmLanguageServer { "${env:USERPROFILE}/.config/efm-langserver/config.yaml" }

  mpv
  {
    Switch( ${os} )
    {
      Linux       { "${env:HOME}/.config/mpv"  }
      Windows_NT  { "${env:APPDATA}\\mpv"      }
      Darwin      { "${env:HOME}/.config/mpv"  }
    }
  }
  mpsyt
  {
    Switch( ${os} )
    {
      Linux       { "${env:HOME}/.config/mps-youtube"  }
      Windows_NT  { "${env:APPDATA}\\mps-youtube"      }
      Darwin      { "${env:HOME}/.config/mps-youtube"  }
    }
  }
}
