sudo dd if=/dev/zero of=/swapfile bs=1G count=4 iflag=fullblock
sudo chown root:root /swapfile
sudo chmod 0600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
