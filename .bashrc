# ~/.bashrc
[[ $- != *i* ]] && return

# wayland and sway on a T430 (optimus: nvidia/intel)
export WLC_DRM_DEVICE=card1

# breaking things up is what I do best...
[[ -d ~/.bash ]] && {
	for f in ~/.bash/*.sh ; do
		[[ -r "${f}" ]] && . "${f}"
	done
	unset f
}
