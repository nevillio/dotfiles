# patchset creater function
function generate_patchset_with_id() {
  local changeId="$1"
  git push origin "HEAD:refs/changes/$changeId"
}

#function to lookup the usage of flag from the help page
function flag_inspector(){
    local command=$1
    shift
    if [ $# -eq 0 ]; then
	echo "Error: No flags were provided" >&2
	return 1
    else
	#Retrieve doc for each flag
	for flag do # Same as for flag in "$@"; do
	    echo $flag
	    doc=$("$command" --help | rg -m 1 -A 5 -e "^\s+-$flag")
	    if [[ -z $doc ]]; then
		echo -e "Error: Flag '$flag' not found for command '$command'\n" >&2
	    else
		echo -e "$doc\n"
	    fi
	done
    fi
}

function reconnect_network() {
  if [ -z "$1" ]; then echo "No network provided"; return; fi
  current_network=$(iwgetid -r)

  if [ "$current_network" != "$1" ]; then {
    echo "Connected to $current_network. Reconnecting to $1"
    nmcli connection down "$current_network"
    nmcli connection up "$1"
  }
  fi
}

dir_scout() {
    files_list=$(fd -tf -d 1 $1)
	echo "files\n"
}

