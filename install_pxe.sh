# Check the Proxmox docs to ensure you've met the prerequisites for this script. You must have the network config completed
# before beginning this process. If unsure, please see the docs here:
# https://pve.proxmox.com/wiki/Install_Proxmox_VE_on_Debian_Stretch

# Everything in this script requires sudo privileges, so it's better to simply run this script as sudo

echo "deb http://download.proxmox.com/debian/pve stretch pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
wget http://download.proxmox.com/debian/proxmox-ve-release-5.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-5.x.gpg

# optional, if you have a changed default umask
chmod +r /etc/apt/trusted.gpg.d/proxmox-ve-release-5.x.gpg
apt update && apt dist-upgrade

# NOTE: If you have enabled another arch (typically, i386 to run some older software) and apt complains about
# not being able to find /binary-i386: "Unable to find expected entry 'pve/binary-i386/Packages'"
# you need to remove other arch or use instead the row:
#deb [arch=amd64] http://download.proxmox.com/debian/pve stretch pve-no-subscription
# this is because Proxmox repository does not have any other arch besides amd64.
# more info on multiarch on debian on: https://wiki.debian.org/Multiarch/HOWTO.

apt-get install -y proxmox-ve postfix open-iscsi
apt remove os-prober
# These steps are optional: if you want to remove the Debian kernel and only keep the Proxmox kernel.
apt remove linux-image-amd64 linux-image-4.9.0-3-amd64
update-grub
