#!/bin/bash

layouts_dir=~/dotfiles/i3/scripts/screenlayouts/
icon=
choosen_layout=$(ls $layouts_dir | sed "s/^/$icon /" | rofi -dmenu | sed "s/^$icon\ //")
bash $layouts_dir/$choosen_layout
