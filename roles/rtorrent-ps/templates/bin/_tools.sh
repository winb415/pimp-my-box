# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# ! FILE IS CONTROLLED BY ANSIBLE, DO NOT CHANGE, OR ELSE YOUR CHANGES WILL BE EVENTUALLY LOST !
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# Bash helper function library
#
# Source this in other scripts.

# common env vars
main_rtrc_file="{{ main_rtrc_file }}"
rutorrent_rtrc_file="{{ rutorrent_rtrc_file }}" # normally the same as 'main_rtrc_file'

# Prevent concurrent script execution
pid_guard() { # scriptname
    local pid=$$
    local script=$1; shift
    local guard="/tmp/$script-$(id -nu).pid"

    if test -f "$guard" ; then
        echo >&2 "ERROR: Script already runs... own PID=$pid"
        ps auxw | grep "$script" | grep -v grep >&2
        exit 1
    fi
    trap "rm -f $guard" EXIT
    echo $pid >"$guard"
}
