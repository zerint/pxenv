# Setup

```
#git clone <this>

apt install syslinux 

cp /usr/lib/PXELINUX/pxelinux.0 tftp/
cp /usr/lib/syslinux/modules/bios/ldlinux.c32 tftp/
cp /usr/lib/syslinux/modules/bios/libcom32.c32 tftp/
cp /usr/lib/syslinux/modules/bios/libutil.c32 tftp/
cp /usr/lib/syslinux/modules/bios/vesamenu.c32 tftp/


#Download live server iso
mount -o loop ubuntu-xx.xx-live-server-amd64.iso /mnt
cp /mnt/casper/vmlinuz tftp/
cp /mnt/casper/initrd tftp/
umount /mnt

mv ubuntu-xx.xx-live-server-amd64.iso httpd/

cp pxelinux.cfg/menu.cfg{.example,}
cp pxelinux.cfg/default{.example,}
# Setup pxelinux.cfg based on default.example and menu.cfg.example


# Set the following on the DHCP server, inside the subnet
# next-server x.x.x.x;
# filename "pxelinux.0";
# or with KVM, add a <bootp> to the network config, ex: /etc/libvirt/qemu/networks/default.xml
# <dhcp>
#   ...
#   <bootp file='pxelinux.0' server='x.x.x.x'/>
# </dhcp>

docker build -t pxeserver .
docker run -dt --network=host -v $(pwd)/pxelinux.cfg:/srv/tftp/pxelinux.cfg:ro pxeserver
docker run -dt -p 80:80 -v $(pwd)/httpd:/usr/local/apache2/htdocs httpd:alpine3.17
```
