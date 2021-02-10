if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep i3 || [[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx .xinitrc -- vt1 &> /dev/null
fi
