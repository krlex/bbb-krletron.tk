#!/usr/bin/env bash

#export DOMAIN="krletron.tk"
export DOMAIN="sysadmins.cf"
export SUBNAME="class"
export IP_ADDRESS="$(gcloud compute instances list | tail -n+2 | awk '{print $1, $5}' |  awk '/$SUBNAME/{getline;getline;print $2}')"
export DNSZONE="krletron"

config() {

  gcloud dns record-sets transaction start --zone=$DNSZONE
  sleep 10

  gcloud dns --project=$PROJECT record-sets transaction add $IP_ADDRESS --name=$SUBNET.$DOMAIN \
  --ttl="30" \
  --type="A" \
  --zone=$DNSZONE

  sleep 5

  gcloud dns --project=$PROJECT record-sets transaction execute --zone=$DNSZONE

}

config
