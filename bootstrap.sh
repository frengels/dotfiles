#!/usr/bin/env sh

stowables=(
  git
  gdb
  sway
  waybar
  alacritty
  termite
  guile
  htop
  neovim
  i3
  xinit
  polybar
  backgrounds
  kitty
  xmodmap
  gtk
)

for stowable in ${stowables[@]}
do
	stow $stowable
	stowres=$?
	echo -n "stowing \"$stowable\""
	if [ $stowres -eq 0 ]
	then
		echo -e " - \e[1;32mDONE\e[0m"
	else
		echo -e " - \e[1:31mFAIL\e[0m"
	fi
done
