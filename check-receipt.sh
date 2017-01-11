
#!/bin/bash

function usage
{
    echo "usage: $0 -r receipt-file -p password [--sandbox] | -h"
    echo ""
    echo "Examples:"
}

receiptfile=
password=
verificationurl=https://buy.itunes.apple.com/verifyReceipt

while [ "$1" != "" ]; do
	case $1 in
		-r | --receipt-file )		shift
						receiptfile=$1
						;;
		-p | --password ) 	        shift
						password=$1
						;;
		-s | --sandbox ) 	        shift
						verificationurl=https://sandbox.itunes.apple.com/verifyReceipt
						;;
		-h | --help )           	usage
						exit
						;;
		* )                     	usage
						exit 1
	esac
	shift
done

if [ "$receiptfile" == "" ]; then
	usage
	exit 1
fi

if [ "$password" == "" ]; then
	usage
	exit 1
fi

echo '{"receipt-data":"'`cat $receiptfile`'", "password":"'$password'"}' > /tmp/receipt.json
curl -X POST -d @/tmp/receipt.json $verificationurl
rm /tmp/receipt.json
