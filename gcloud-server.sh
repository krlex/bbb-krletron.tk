#!/usr/bin/env bash


export PROJECT="testing-system-270517" #Project name on GCP
export DOMAIN="krletron.tk"            #Domain name
export SUBNAME="class"                 #Subdomain
export OS="ubuntu-1604-xenial-v20200521" #Image on GCP
export POS="ubuntu-os-cloud"           # images-projects of gcp
export MACHINE="n1-standard-4"         # Configuration GCP VM
export DISKTYPE="pd-ssd"               # Select HDD/SSD
export DISKSYZE="10GB"                 # Size of HDD/SSD
export SUBNET="default"
export ZONE="us-central1-a"            # Which zone you want to install your VM

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
