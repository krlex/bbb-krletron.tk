#!/usr/bin/env bash

export DOMAIN="krletron.tk"
export SUBNAME="class"
export IP_ADDRESS="$(gcloud compute instances list | tail -n+2 | awk '{print $1, $5}' |  awk '/$SUBNAME/{getline;getline;print $2}')"
export DNSZONE="krletron"

export START_DNS= $(gcloud dns record-sets transaction start --zone=$DNSZONE)
export SET_DNS= $(gcloud dns --project=$PROJECT record-sets transaction add $IP_ADDRESS --name=$SUBNET.$DOMAIN \
  --ttl="30" \
  --type="A" \
  --zone=$DNSZONE)

export EXE_DNS= $(gcloud dns --project=$PROJECT record-sets transaction execute --zone=$DNSZONE)

$START_DNS
$SET_DNS
$EXE_DNS
