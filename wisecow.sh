#!/usr/bin/env bash

SRVPORT=4499
RSPFILE=response

rm -f $RSPFILE
mkfifo $RSPFILE

COWSAY_CMD="/usr/games/cowsay"
FORTUNE_CMD="/usr/games/fortune"

get_api() {
	read line
	echo $line
}

handleRequest() {
    # 1) Process the request
	get_api
	mod=`/usr/games/fortune`

cat <<EOF > $RSPFILE
HTTP/1.1 200


<pre>`$COWSAY_CMD $mod`</pre>
EOF
}

prerequisites() {
	command -v $COWSAY_CMD >/dev/null 2>&1 &&
	command -v $FORTUNE_CMD >/dev/null 2>&1 || 
		{ 
			echo "Install prerequisites."
			exit 1
		}
}

main() {
	prerequisites
	echo "Wisdom served on port=$SRVPORT..."

	while [ 1 ]; do
		cat $RSPFILE | nc -lN $SRVPORT | handleRequest
		sleep 0.01
	done
}

main
