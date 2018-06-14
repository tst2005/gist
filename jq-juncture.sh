#! ./bin/pata.sh

sample1() {
	printf '%s\n' '{
		"db1": [
			{"id": 11, "name": "entry1"},
			{"id": 22, "name": "entry2"},
			{"id": 33, "name": "entry3"},
			{"id": 44, "name": "entry4"}
		],
		"db2": {
			"11": "id11",
			"22": "id22",
			"33": "id33",
			"44": "id44"
		}
	}'
}
echo "## sample1 ##"
sample1| jq .

join1() {
	# with db1 and db2
	jq '.db2 as $db2 |.db1|=map( .id|= $db2[(.|tostring)] )'

	# with db1 and db2 and joined field as id2
	#jq 'def xx($resultfield) .db2 as $db2 |.db1 |= map( .+{ $resultfield: (.| $db2[(.id|tostring)])} ); xx("id2")'
}
echo "## sample1 | join1 ##"
sample1 | join1

#join1b() {
#	# with db1 and db2 and joined field as id2
#	jq '"id2" as $resultfield) |.db2 as $db2 |.db1 |= map( .+{ $resultfield: (.| $db2[(.id|tostring)])} )'
#}
#echo "## sample1 | join1b ##"
#sample1 | join1b

join2() {
	# with db1 only
	jq '.db2 as $db2 |.db1 | {db1: map( .id|= $db2[(.|tostring)] ) }'
}
echo "## sample1 | join2 ##"
sample1 | join2

join2b() {
	# with db1 only
	jq '.db2 as $db2 |.db1 |= map( .id|= $db2[(.|tostring)] )|del(.db2)'
}
echo "## sample1 | join2b ##"
sample1 | join2b

join3() {
	# with db1 content only
	jq '.db2 as $db2 |.db1|.| map( .id|= $db2[(.|tostring)] )'
}
echo "## sample1 | join3 ##"
sample1 | join3

sample2() {

	printf '%s\n' '{
		"db1": [
			{"id": 11, "name": "entry1"},
			{"id": 22, "name": "entry2"},
			{"id": 33, "name": "entry3"},
			{"id": 44, "name": "entry4"}
		],
		"db2": [
			{"key": 11, "value": "id11"},
			{"key": 22, "value": "id22"},
			{"key": 33, "value": "id22"},
			{"key": 44, "value": "id44"}
		]
	}'
}
echo "## sample2 ##"
sample2| jq .

join21() {
	# with db1 content only
	jq '.db2 as $db2 |.db1| map(
		.id |= (
			. as $k | $db2|map(if (.key==$k) then (.value) else empty end)[0]
		)
	)'
}
echo "## sample2 | join21 ##"
sample2 | join21

