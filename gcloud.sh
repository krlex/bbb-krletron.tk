#!/usr/bin/env bash


PROJECT=testing-system-270517
DOMAIN=krletron.tk
SUBNAME=class
IP_ADDRESS= gcloud compute instances list | tail -n+2 | awk '{print $1, $5}' |  awk '/$SUBNAME/{getline;getline;print $2}'
OS=ubuntu-1604-xenial-v20200429
POS=ubuntu-os-cloud
MACHINE=n1-standard-4
DISKTYPE=pd-ssd
DISKSYZE=10GB
SUBNET=default
ZONE=us-central1-a


gcloud beta compute --project=$PROJECT \
instances create $SUBNAME --zone=$ZONE \
                      --machine-type=$MACHINE \
                      --subnet=$SUBNET\
                      --network-tier=PREMIUM \
                      --maintenance-policy=MIGRATE \
                      --service-account=428196102848-compute@developer.gserviceaccount.com \
                      --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
                      --tags=http-server,https-server \
                      --image=$OS \
                      --image-project=$POS \
                      --boot-disk-size=$DISKSYZE \
                      --boot-disk-type=$DISKTYPE \
                      --boot-disk-device-name=$SUBNAME\
                      --no-shielded-secure-boot \
                      --shielded-vtpm \
                      --shielded-integrity-monitoring \
                      --reservation-affinity=any

gcloud beta dns --project=testing-system-270517 record-sets transaction start --zone=krletron
#
gcloud beta dns --project=testing-system-270517 record-sets transaction add $IP_ADDRESS --name=$SUBNAME.$DOMAIN. --ttl=300 --type=A --zone=krletron
#
#gcloud beta dns --project=testing-system-270517 record-sets transaction remove $IP_ADDRESS --name=$SUBNAME.$DOMAIN. --ttl=300 --type=A --zone=krletron
#
gcloud beta dns --project=testing-system-270517 record-sets transaction execute --zone=krletron
