#!/bin/bash
#
install -m 700 -d ~/.ssh && echo -n 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDcS4DL4m9r7626QStAY7/rHTW0xPzgZLuefFJB2TV/ZN3ZuRwKPxd49qLaE85Z/tpnl51CfU3RmI+ppmk/EUfNMvlaQMVDaAZSRhnE/k5pFSkih4dm8zotTytuywMKvKWeLiVUPupRjMDJkmw3ArRwZZruNPd8BNy9sWwgtdQ5TYlDfG45oQLGxKFsvTyqc0h+hIFK26fLtcDRBlCbUuRD2mEiO7m9yN6ul6Bljzq5a6GtvMQcw19Z27O9zrGmKpSBOBZFZ6HY5k2SVC7qEhI7YFfSeyarpsIdiTP4VaQtqCEowOMcK5g/+f/qIzVmK3z/Ms/in8zOCk38CLf1q+5J vvk.mpv@gmail.com' > ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys 

sudo su
yum  -y groupinstall "Development Tools" && \
yum -y install wget lshw kernel-devel epel-release && \
sed -i "s/mirrorlist=https/mirrorlist=http/" /etc/yum.repos.d/epel.repo && \
yum -y install dkms 
#Disable nouveau driver by changing the configuration /etc/default/grub file
# https://linuxconfig.org/how-to-install-the-nvidia-drivers-on-centos-8
# https://www.tecmint.com/install-nvidia-drivers-in-linux/
echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf
mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r).img.bak  
dracut -v /boot/initramfs-$(uname -r).img $(uname -r)
reboot

#
#get and install proprietary driver Nvidia
wget http://us.download.nvidia.com/XFree86/Linux-x86_64/430.50/NVIDIA-Linux-x86_64-430.50.run && \
sudo chmod +x  NVIDIA-Linux-x86_64-430.50.run && \
sudo ./NVIDIA-Linux-x86_64-430.50.run --kernel-source-path=/usr/src/kernels/3.10.0-1062.1.2.el7.x86_64
#
# install last docker
sudo yum -y install -y yum-utils \
  device-mapper-persistent-data \
  lvm2 && \
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo && \
sudo yum -y install docker-ce docker-ce-cli containerd.io && \
sudo systemctl start docker && \

sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose $$ \
sudo chmod +x /usr/local/bin/docker-compose && \
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

