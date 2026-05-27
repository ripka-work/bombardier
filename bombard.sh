#!/bin/bash
if [ -z "$LOOPS" ]
then
  LOOPS=1;
fi;

i=1
while [ $i -le $LOOPS ]; 
do  
echo $i; 
((i+=1)); 
TOK=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/identity?audience=$SVC_ADDR" -H "Metadata-Flavor: Google");

bombardier -c $USRS -d $DUR -r $LMT -t $TMOUT -H "Authorization: Bearer $TOK" -H "Content-Type: application/x-www-form-urlencoded" -m GET -p r $LB_IP

done
