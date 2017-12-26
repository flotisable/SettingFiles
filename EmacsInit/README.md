# EmacsInit
for backup my emacs init file

[Traditional Chinese README](README_zh-TW.md)

# Indexes
- [Files](#files)
- [To Use Emacs Init File](#to-use-emacs-init-file)
  - [For Linux and Mac](#for-linux-and-mac)
- [Install](#install)
  - [Using Install Script](#using-install-script)
    - [Modify The Script](#modify-the-script)
    - [Using Arguments](#using-arguments)
  - [Using Makefile](#using-makefile)
- [Getting Start](#getting-start)
- [KeyBindings](#key-bindings)
- [Packages](#packages)

# Files
- **.emacs**      : settings for [emacs](https://www.gnu.org/software/emacs/index.html)
- **install.sh**  : install script for **.emacs**
- **makefile**    : makefile for **.emacs**

# To Use Emacs Init File
open the emacs and type **C-h r**, it will show the emacs manual

then type **g Init File** and press **Enter**, it will show the help file about where to put emacs init file

I will talk about where I place my emacs init file below as an example

## For Linux and Mac
I place the ".emacs" at "$HOME/"

this is the default directory of emacs init file

# Install
## Using Install Script
the script is written in **bash** script, so any shell support bash script can be used

to use the script

- first ```chmod u+x install.sh``` to make the script executable
- modify the variables in script if neccessary
- type ```./install.sh``` to install **.emacs** file

there are two ways to set the variables in the script

### Modify The Script
- the directory path **targetDir**

  this is the installed directory of **.emacs**
- the target file name **initTargetName**

  this is the installed file name of **.emacs**

### Using Arguments
there are three arguments of the script, if not being specified, the default will be used

1. initSourceName : the source file name of **.emacs**
2. targetDir      : the installed file name of **.emacs**
3. initTargetName : the installed directory of **.emacs**

## Using Makefile
makefile is written for those who want to use **make** to finish the task

it is also used to ease the update of source file from me

currently, the makefile support the following options
- default   : update the source file

  this is **make** with no option
- install   : install **.emacs**

  actually this option use the install script, so make sure the install script is executable
- uninstall : uninstall **.emacs**

to change the path and file name of **.emacs**, just modify the variables of makefile

the variables is the same as the install script

# Getting Start
for using the emacs init file first time, you need to decide whether you want to use the packages or not

if you don't want to use packages, just delete the corresponding lines in the emacs init file

if you want to use the packages, type ```<M-x> list-packages``` in emacs

it will open the default emacs package manager

find the packages listed in the [Packages](#packages) in the package manager

type ```i``` to mark the package as install

after mark all the packages, type ```x``` to install the packages

then just have fun with the init file
# Key Bindings
- C-c a : open the org agenda dispatcher

# Packages
- evil        : Extensable VI Layer
- ox-ioslide  : the org mode package to export to Google I/O slide
