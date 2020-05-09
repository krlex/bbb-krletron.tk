#!/usr/bin/env bash

DOMAIN=krletron.tk
SUBNAME=class
IP_ADDRESS= gcloud compute instances list | tail -n+2 | awk '{print $1, $5}' |  awk '/$SUBNAME/{getline;getline;print $2}'
DNSZONE=krletron

timeout --foreground 1m \
  gcloud dns record-sets transaction start --zone="$DNSZONE"
timeout --foreground 1m \
  gcloud dns record-sets transaction add --zone="$DNSZONE" --name="$SUBNAME.$DOMAIN" --ttl="3600" --type A $IP_ADDRESS
timeout --foreground 1m \
  gcloud dns record-sets transaction execute --zone="$DNSZONE"
