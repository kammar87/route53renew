#!/bin/bash
renewal="Certificate not yet due for renewal"
timestamp=`date +'%Y%m%d%H%M'`

if [ ! -d /usr/src/app/tmp ]; then
mkdir /usr/src/app/tmp
fi
if [ ! -d /usr/src/app/ssl ]; then
mkdir /usr/src/app/ssl
fi

update_cert()
{
echo "Updating renewed /etc/ssl/web/$DOMAIN cert "
cp /etc/ssl/web/$DOMAIN* /usr/src/app/ssl/.
tar -zcvf /usr/src/app/ssl/$DOMAIN-$timestamp.tar.gz /usr/src/app/ssl/$DOMAIN*
cp /etc/letsencrypt/live/$DOMAIN/cert.pem /etc/ssl/web/$DOMAIN.crt
cp /etc/letsencrypt/live/$DOMAIN/privkey.pem /etc/ssl/web/$DOMAIN.key

# cp /etc/letsencrypt/live/$DOMAIN/cert.pem /usr/src/app/tmp/$DOMAIN.crt
# cp /etc/letsencrypt/live/$DOMAIN/privkey.pem /usr/src/app/tmp/$DOMAIN.key
# tar -zcvf /usr/src/app/tmp/$DOMAIN-$timestamp.tar.gz /usr/src/app/tmp/$DOMAIN.*    
}


# #GENERATE DOMAIN
log=`certbot certonly -n --agree-tos --email $EMAIL --dns-route53 --dns-route53-propagation-seconds 30 -d *.$DOMAIN`
echo $log

if echo "$log"|grep -q "$renewal"; then
echo "Will not update /etc/ssl/web/$DOMAIN cert"
else
update_cert()

fi

