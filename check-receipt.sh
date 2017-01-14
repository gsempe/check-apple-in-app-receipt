
#!/bin/bash

function usage
{
    echo "usage: $0 -r receipt-file -p password [--sandbox] | -h"
    echo ""
    echo "Status codes:"
    echo "21000 The App Store could not read the JSON object you provided."
    echo "21002 The data in the receipt-data property was malformed or missing."
    echo "21003 The receipt could not be authenticated."
    echo "21004 The shared secret you provided does not match the shared secret on file for your account. Only returned for iOS 6 style transaction receipts for auto-renewable subscriptions."
    echo "21005 The receipt server is not currently available."
    echo "21006 This receipt is valid but the subscription has expired. When this status code is returned to your server, the receipt data is also decoded and returned as part of the response. Only returned for iOS 6 style transaction receipts for auto-renewable subscriptions."
    echo "21007 This receipt is from the test environment, but it was sent to the production environment for verification. Send it to the test environment instead."
    echo "21008 This receipt is from the production environment, but it was sent to the test environment for verification. Send it to the production environment instead."
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
