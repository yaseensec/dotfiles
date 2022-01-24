#!/usr/bin/env bash
read -p "Boot VM with UEFI [YES | NO]: " UEFI
  case "$UEFI" in
    [yY]|[yY][eE][sS]) 
        read -p "Boot VM with Secureboot [YES | NO]: " SB
        case "$SB" in
          [yy]|[yY][eE][sS])
            BOOT=loader=/usr/share/edk2-ovmf/x64/OVMF_CODE.secboot.fd,loader.readonly=yes,loader.type=pflash,nvram.template=/usr/share/edk2-ovmf/x64/OVMF_VARS.secboot.fd,loader_secure=yes 
            FEATURES=smm.state=on
            #BOOT=firmware=efi,loader_secure=yes #This doesnt seem to work in Arch atleast as suggested by libivirt
            echo --------------------------------------
            echo "Booting VM with UEFI and SecureBoot "
            echo --------------------------------------
            echo
          ;;
          [nN]|[nN][oO])
            BOOT=loader=/usr/share/edk2-ovmf/x64/OVMF_CODE.fd,loader.readonly=yes
            FEATURES=smm.state=off
            echo ----------------------
            echo "Booting VM with UEFI"
            echo ----------------------
            echo

          ;;
        esac
    ;;
    [nN]|[nN][oO])
          BOOT=hd
          FEATURES=smm.state=off
          echo ----------------------
          echo "Booting VM with BIOS"
          echo ----------------------
          echo
    ;;
  esac
  

# if [[ $UEFI = YES  ]]; then
#   read -p "Boot VM with Secureboot [YES | NO]: " SB
#     if [[ $SB = YES ]]; then
#       BOOT=loader=/usr/share/edk2-ovmf/x64/OVMF_CODE.secboot.fd,loader.readonly=yes,loader.type=pflash,nvram.template=/usr/share/edk2-ovmf/x64/OVMF_VARS.secboot.fd,loader_secure=yes 
#       FEATURES=smm.state=on
#       #BOOT=firmware=efi,loader_secure=yes #This doesnt seem to work in Arch atleast as suggested by libivirt
#       echo --------------------------------------
#       echo "Booting VM with UEFI and SecureBoot "
#       echo --------------------------------------
#       echo
#       else
#         BOOT=loader=/usr/share/edk2-ovmf/x64/OVMF_CODE.fd,loader.readonly=yes
#         FEATURES=smm.state=off
#         echo ----------------------
#         echo "Booting VM with UEFI"
#         echo ----------------------
#         echo
#     fi 
#   else
#     BOOT=hd
#     FEATURES=smm.state=off
#     echo ----------------------
#     echo "Booting VM with BIOS"
#     echo ----------------------
#     echo
# fi

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
read -p "Video Device: " VIDEO
read -p "Kickstart File Location: " KSLOCATION
read -p "Kickstart File Name: " KSFILENAME

OS_TYPE=linux

sudo virt-install \
     --boot ${BOOT} \
     --features ${FEATURES} \
     --name ${NAME} \
     --memory=${MEMORY} \
     --vcpu=${VCPU} \
     --network network:${NETWORK} \
     --disk pool=${DISK_POOL},size=${DISK_SIZE} \
     --os-type=${OS_TYPE} \
     --os-variant=${OS_VARIANT} \
     --location ${ISO_LOCATION}/${ISO_NAME}.iso \
     --graphics=${GRAPHICS} \
     --console pty,target_type=serial \
     --initrd-inject ${KSLOCATION}/${KSFILENAME} \
     --extra-args "inst.ks=file:/${KSFILENAME} console=tty0 console=ttyS0,115200n8" \ 

