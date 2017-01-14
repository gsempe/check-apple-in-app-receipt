`check-receipt` is a small tool to check Apple In-App purchase receipts

## Usage

```sh
./check-receipt.sh -r receipt-file -p password [--sandbox] | -h
```

receipt-file: A file containing the base64 encoded receipt

## Example

```sh
./check-receipt.sh -r receipt-in-app-empty -p password
```

```json
{
   "status":0,
   "environment":"Production",
   "receipt":{
      "receipt_type":"Production",
      "adam_id":111111111,
      "app_item_id":111111111,
      "bundle_id":"com.getonce.ios",
      "application_version":"XYZ",
      "download_id":11111111111111,
      "version_external_identifier":111111111,
      "receipt_creation_date":"2016-12-22 21:38:01 Etc/GMT",
      "receipt_creation_date_ms":"1482442681000",
      "receipt_creation_date_pst":"2016-12-22 13:38:01 America/Los_Angeles",
      "request_date":"2017-01-14 23:08:12 Etc/GMT",
      "request_date_ms":"1484435292075",
      "request_date_pst":"2017-01-14 15:08:12 America/Los_Angeles",
      "original_purchase_date":"2016-03-05 01:10:03 Etc/GMT",
      "original_purchase_date_ms":"1457140203000",
      "original_purchase_date_pst":"2016-03-04 17:10:03 America/Los_Angeles",
      "original_application_version":"XYZ",
      "in_app":[

      ]
   }
}
```

## Status codes

**0** Success  
**21000** The App Store could not read the JSON object you provided.  
**21002** The data in the receipt-data property was malformed or missing.  
**21003** The receipt could not be authenticated.  
**21004** The shared secret you provided does not match the shared secret on file for your account. Only returned for iOS 6 style transaction receipts for auto-renewable subscriptions.  
**21005** The receipt server is not currently available.  
**21006** This receipt is valid but the subscription has expired. When this status code is returned to your server, the receipt data is also decoded and returned as part of the response. Only returned for iOS 6 style transaction receipts for auto-renewable subscriptions.  
**21007** This receipt is from the test environment, but it was sent to the production environment for verification. Send it to the test environment instead.  
**21008** This receipt is from the production environment, but it was sent to the test environment for verification. Send it to the production environment instead.