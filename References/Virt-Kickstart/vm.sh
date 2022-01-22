#!/usr/bin/env bash

#Variables

read -p "Name of the Machine: " NAME
read -p "Memory in MB: " MEMORY 
read -p "VCPU: " VCPU 
read -p "Network Name: " NETWORK 
read -p "Disk Pool: " DISK_POOL
read -p "Disk Size: " DISK_SIZE
read -p "OS Variant: " OS_VARIANT
read -p "ISO Location: " ISO_LOCATION
read -p "ISO Name: " ISO_NAME
read -p "Graphics: " GRAPHICS
read -p "Kickstart File Location: " KSLOCATION
read -p "Kickstart File Name: " KSFILENAME

OS_TYPE=linux

sudo virt-install \
     --name ${NAME} \
     --memory=${MEMORY} \
     --vcpu=${VCPU} \
     --network network:${NETWORK} \
     --disk pool=${DISK_POOL},size=${DISK_SIZE} \
     --os-type=${OS_TYPE} \
     --os-variant=${OS_VARIANT} \
     --location ${ISO_LOCATION}/${ISO_NAME} \
     --graphics=${GRAPHICS} \
     --boot loader=/usr/share/edk2-ovmf/x64/OVMF_CODE.secboot.fd \
     --boot loader.readonly=yes,loader.type=pflash,nvram.template=/usr/share/edk2-ovmf/x64/OVMF_VARS.secboot.fd,loader_secure=yes \
     --console pty,target_type=virtio \
     --initrd-inject ${KSLOCATION}/${KSFILENAME} \
     --extra-args "inst.ks=file:/${KSFILENAME}" \
     --features smm.state=on

