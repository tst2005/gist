#! /bin/sh
find -type d -name .git | while read -r d; do
	echo "$d"
	(
	cd -- "$d" && cd .. && git fsck 2>/dev/null && git gc --auto -q && git gc -q
	git fsck 2>&1 |grep -v ^Checking
	)
	echo
done
