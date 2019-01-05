#!/usr/bin/env sh

stowables=(
  sway
)

for stowable in $stowables
do
	stow $stowable
done
