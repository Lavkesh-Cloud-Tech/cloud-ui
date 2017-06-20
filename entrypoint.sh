#!/bin/bash
set -e

# if [ -z "$RUN_ENV" ]; then
#     #Fail
#     echo "No RUN_ENV specified!"
#     exit 1
# fi

# for f in /cloud-ui/template/app*.*.js; do sed 's@{{env}}@'"$RUN_ENV"'@' "$f" > /usr/share/nginx/html/js/${f##*/}; done

# Add nginx as command if needed
if [[ "$1" == -* ]]; then
    set -- nginx "$@"
fi

# if [ -z "$API_GATEWAY_URL" ]; then
#     #Fail
#     echo "No API_GATEWAY_URL specified!"
#     exit 1
# fi

ACCESS_LOG=/var/log/nginx/access.log

sed -i.bak "s|ACCESS_LOG|$ACCESS_LOG|g" /etc/nginx/nginx.conf
# sed -i.bak "s|API_GATEWAY_URL|$API_GATEWAY_URL|g" /etc/nginx/nginx.conf

DNS_SERVER=$(cat /etc/resolv.conf |grep -i nameserver|head -n1|cut -d ' ' -f2)
sed -i.bak "s|DNS_SERVER|$DNS_SERVER|g" /etc/nginx/nginx.conf

# echo "$RUN_ENV exec $@"
exec "$@"
