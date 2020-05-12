#!/usr/bin/env bash

DOMAIN="krletron.tk"
SUBNAME="class"
IP_ADDRESS="$(gcloud compute instances list | tail -n+2 | awk '{print $1, $5}' |  awk '/$SUBNAME/{getline;getline;print $2}')"
DNSZONE="krletron"

gcloud dns record-sets transaction start --zone="$DNSZONE"

gcloud dns record-sets transaction add --zone="$DNSZONE" \
                                       --name="$SUBNAME.$DOMAIN" \
                                       --type="A" \
                                       --ttl="300" "$SUBNAME.$DOMAIN"

gcloud dns record-sets transaction execute -z=$DNSZONE

#gcloud beta dns --project=testing-system-270517 record-sets transaction start --zone=krletron
#
#gcloud beta dns --project=testing-system-270517 record-sets transaction add 572.314.45.11 --name=class.krletron.tk. --ttl=300 --type=A --zone=krletron
#
#gcloud beta dns --project=testing-system-270517 record-sets transaction execute --zone=krletron
