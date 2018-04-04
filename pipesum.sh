#!/bin/sh
sumfile="$(mktemp)"
tmpfile="$(mktemp)"
trap "rm -f -- '$tmpfile' '$sumfile'" EXIT
verbose=false
cmd='auto'
hashvalue=''
while [ $# -gt 0 ]; do
	case "$1" in
	('-v') verbose=true;;
	('-q') verbose=false;;
	(auto|md5sum|sha*sum) cmd="$1";;
	(*)
		if [ -n "$hashvalue" ]; then
			echo >&2 "Only one hashvalue is supported"
			exit 1
		fi
		hashvalue="$1"
	;;
	esac
	shift
done
showusage=true
if [ -n "$hashvalue" ]; then
	if [ "$cmd" = "auto" ]; then
		case "${#hashvalue}" in
		(0) ;;
		(32) cmd=md5sum;;
		(40) cmd=sha1sum;;
		(56) cmd=sha224sum;;
		(64) cmd=sha256sum;;
		(96) cmd=sha384sum;;
		(128) cmd=sha512sum;;
		(*)
			echo >&2 "autodetection failed unknown hashsize"
			exit 1
		;;
		esac
	fi
	case "$cmd" in
		(md5sum|sha1sum|sha224sum|sha256sum|sha384sum|sha512sum) showusage=false;;
	esac
fi
if ${showusage:-false}; then
	echo >&2 "Usage: $0 [-v|-q] [md5sum|sha1sum|sha224sum|sha256sum|sha384sum|sha512sum] <checksumvalue>"
	exit 1
fi
cat ->"$tmpfile"
echo "$hashvalue  $tmpfile">"$sumfile"
if ! "$cmd" >/dev/null 2>&1 -c "$sumfile"; then
	echo >&2 "$0: integrity check failed"
	exit 1
fi
cat -- "$tmpfile"