#/bin/bash
# by Phil Stark
#
# Purpose:  Mass create subdomains
#
# usage:  ./createsubs.sh <user> <domain> <count>

user=$1
domain=$2
count=$3
i=0

while [ $i -lt $count ]
do
	random=`tr -dc "[:alpha:]" < /dev/urandom | head -c 8`

	curl -s -k -H "Authorization: WHM root:`cat ~/.accesshash | tr -d "\n"`" "https://localhost:2087/xml-api/cpanel?user=$user&cpanel_xmlapi_module=SubDomain&cpanel_xmlapi_func=addsubdomain&rootdomain=$domain&domain=$random.$domain" | grep reason | sed 's/<reason>//g' | sed 's/<\/reason>//g'
	i=$(( $i + 1 ))

done
