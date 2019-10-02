#!/bin/bash
#
install -m 700 -d ~/.ssh && echo -n 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDcS4DL4m9r7626QStAY7/rHTW0xPzgZLuefFJB2TV/ZN3ZuRwKPxd49qLaE85Z/tpnl51CfU3RmI+ppmk/EUfNMvlaQMVDaAZSRhnE/k5pFSkih4dm8zotTytuywMKvKWeLiVUPupRjMDJkmw3ArRwZZruNPd8BNy9sWwgtdQ5TYlDfG45oQLGxKFsvTyqc0h+hIFK26fLtcDRBlCbUuRD2mEiO7m9yN6ul6Bljzq5a6GtvMQcw19Z27O9zrGmKpSBOBZFZ6HY5k2SVC7qEhI7YFfSeyarpsIdiTP4VaQtqCEowOMcK5g/+f/qIzVmK3z/Ms/in8zOCk38CLf1q+5J vvk.mpv@gmail.com' > ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && \


sudo yum  -y groupinstall "Development Tools" && \
sudo yum -y install wget kernel-devel epel-release && \
sudo sed -i "s/mirrorlist=https/mirrorlist=http/" /etc/yum.repos.d/epel.repo && \
sudo yum -y install dkms 

#Disable nouveau driver by changing the configuration /etc/default/grub file


#### BIOS:  ####
#sudo grub2-mkconfig -o /boot/grub2/grub.cfg
#### EFI:   ####
sudo grub2-mkconfig -o /boot/efi/EFI/centos/grub.cfg

sudo reboot
#
#get and install proprietary driver Nvidia
wget http://us.download.nvidia.com/XFree86/Linux-x86_64/430.50/NVIDIA-Linux-x86_64-430.50.run
sudo bash NVIDIA-Linux-x86_64-*

# install last docker
sudo yum -y install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose





#sudo yum install epel-release dkms libstdc++.i686
# get actusl version https://www.nvidia.com/en-us/drivers/unix/


#echo "Installing CUDA..."

#wget https://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-10.1.243-1.x86_64.rpm
#sudo rpm -i cuda-repo-*.rpm
#sudo yum install cuda
