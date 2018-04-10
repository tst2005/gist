#!/bin/sh

deadlink() {
	local NO_ABS=0
	local NO_REL=0
	while [ $# -gt 0 ]; do
		case "$1" in
		-h|--help)
			echo "Usage: $0 [--na|--no-absolute|--nr|--no-relative] [--] <directory>"; exit 0;;
		--na|--no-abs*) shift ; NO_ABS=1 ;;
		--nr|--no-rel*) shift ; NO_REL=1 ;;
		--) shift; break ;;
		-*) echo >&2 "Bad option $1" ; exit 1 ;;
		*) break;
		esac
	done
	while [ $# -gt 0 ]; do
		find "$1" -type l -printf "p %P\nl %l\n" \
		| (
		local file=""
		local from=""
		local link=""
		while read type line; do
			case "$type" in
			p)
				file="$line"
				from="$(dirname "$file")"
			;;
			l)
				link="$line"
				if case "$link" in
					/*) false ;;
					*)  true ;;
				esac; then
					[ $NO_REL -eq 1 ] && continue
					link="$1/$from/$link"
				else
					[ $NO_ABS -eq 1 ] && continue
				fi
				[ ! -e "$link" ] && echo "!! $1/$file -> $link"
			;;
			esac
		done
		) 
		shift;
	done
}
deadlink "$@"