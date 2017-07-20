
# alt which command
which() {
	type -pa "$@" | head -n 1
	return ${PIPESTATUS[0]}
}

# Show `file` info for a command in PATH without needing the full path
# `file $(which command)` is annoying with symlinks (python)
binfo() {
  [ -z $1 ] && {
    echo "Usage: binfo command";
    return;
  } || local barg=$1

  local file=$(which $barg 2>/dev/null)

	# make sure it exists
	[ -z $file ] && { 
		echo "$barg not found in \$PATH"; 
		return; 
	}

  # follow if symlink
	[ -h $file ] && {
		echo -e "\t$(tput bold)$file -> $(realpath $file)$(tput sgr0)\n";
		file=$(realpath $file);
  }

  [ -a $file ] && file $file || echo $file
}

# Try to open the file if it's entered as a command
# this is horrendous and should not really be used...

function command_not_found_handle {
	local file=$1
	local ext="${file##*.}"

	[[ -f ./$file ]] && file=$(realpath ./$file) || {
		for dir in docs downloads desktop templates; do
			[[ -f ~/${dir}/${file} ]] && file=$(realpath ~/${dir}/${file}) && break
		done
	}
	
	[[ -f "${file}" ]] && [[ -n "${ext}"  ]] || {
		echo "bash: ${1}: command not found"
		exit 127 &>/dev/null
	}

	[[ $(file ${file} 2>/dev/null) == *text* ]] && exec vim ${file}

	case $ext in
		pdf)
			exec zathura ${file} &
			;;
		html)
			exec firefox ${file} &
			;;
		*)
			echo "bash: ${1}: unkown filetype: ${ext}"
			exit 127 &>/dev/null
			;;
	esac
}

function sysload {
	local l=$(egrep -o ^[0-9]+\.[0-9]{2} /proc/loadavg|tr -d '.')
	echo $((10#$l))
}

