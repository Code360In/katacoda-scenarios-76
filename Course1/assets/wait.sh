#!/bin/bash
clear

vtx=$(egrep -i '^flags.*(vmx|svm)' /proc/cpuinfo | wc -l)
if [ $vtx = 0 ] ; then echo "[Error] Environment Checking Error!!! Please Reload Page!!!"&& shutdown now
fi

clear
echo Cloning noVNC...
git clone https://github.com/novnc/noVNC.git > /dev/null 2>&1
wget https://github.com/kmille36/katacoda-scenarios/raw/main/index.html > /dev/null 2>&1
mv index.html noVNC/index.html
echo Starting noVNC Server...
nohup ./noVNC/utils/novnc_proxy --listen 8080 --vnc localhost:5901 &>/dev/null &
echo Getting some update...
sudo apt-get update -y > /dev/null 2>&1
nohup sudo apt-get install -y qemu-kvm &>/dev/null &
echo Downloading VM...
curl -L -k -o win10ltsc.qcow2 https://v.gd/8WLcip
availableRAMcommand="free -m | tail -2 | head -1 | awk '{print \$7}'"
availableRAM=$(echo $availableRAMcommand | bash)
custom_param_ram="-m "$(expr $availableRAM)"M"
cpus=$(lscpu | grep CPU\(s\) | head -1 | cut -f2 -d":" | awk '{$1=$1;print}')
nohup sudo qemu-system-x86_64 -net nic -net user,hostfwd=tcp::3389-:3389 -show-cursor $custom_param_ram -soundhw hda -localtime -enable-kvm -cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time,+nx -M pc -smp cores=$cpus -vga std -machine type=pc,accel=kvm -usb -device usb-tablet -k en-us -drive file=win10ltsc.qcow2,index=0,media=disk,format=qcow2,if=virtio -boot once=d -vnc :1 &>/dev/null &
clear 
echo All done! Please click Open Desktop to access your VM!
wget -O spinner.sh https://bit.ly/3rSMCk1 > /dev/null 2>&1
chmod +x spinner.sh
./spinner.sh sleep 99999
