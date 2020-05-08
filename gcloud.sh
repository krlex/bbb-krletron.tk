#!/usr/bin/env bash

NAME=class
IP_ADDRESS= gcloud compute instances list | tail -n+2 | awk '{print $1, $5}' |  awk '/$NAME/{getline;getline;print $2}'

gcloud beta compute --project=testing-system-270517 \
instances create class --zone=us-central1-a \
                      --machine-type=n1-standard-4 \
                      --subnet=default \
                      --network-tier=PREMIUM \
                      --maintenance-policy=MIGRATE \
                      --service-account=428196102848-compute@developer.gserviceaccount.com \
                      --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
                      --tags=http-server,https-server \
                      --image=ubuntu-1604-xenial-v20200429 \
                      --image-project=ubuntu-os-cloud \
                      --boot-disk-size=10GB \
                      --boot-disk-type=pd-ssd \
                      --boot-disk-device-name=$NAME\
                      --no-shielded-secure-boot \
                      --shielded-vtpm \
                      --shielded-integrity-monitoring \
                      --reservation-affinity=any

gcloud beta dns --project=testing-system-270517 record-sets transaction start --zone=krletron
#
gcloud beta dns --project=testing-system-270517 record-sets transaction add $IP_ADDRESS --name=$NAME.krletron.tk. --ttl=300 --type=A --zone=krletron
#
#gcloud beta dns --project=testing-system-270517 record-sets transaction remove $IP_ADDRESS --name=$NAME.krletron.tk. --ttl=300 --type=A --zone=krletron
#
gcloud beta dns --project=testing-system-270517 record-sets transaction execute --zone=krletron
