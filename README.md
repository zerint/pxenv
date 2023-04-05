# Setup

```commandline
git clone <this>
```

### Download live server iso
```commandline
mount -o loop ubuntu-xx.xx-live-server-amd64.iso /mnt
cp /mnt/casper/vmlinuz tftp/
cp /mnt/casper/initrd tftp/
umount /mnt

mv ubuntu-xx.xx-live-server-amd64.iso httpd/
```

### Setup pxelinux.cfg based on default.example and menu.cfg.example
```commandline
cp pxelinux.cfg/menu.cfg{.example,}
cp pxelinux.cfg/default{.example,}
```

### Set the following on the DHCP server, inside the subnet
```
next-server x.x.x.x;  
filename "pxelinux.0"; 
``` 
or with KVM, add a `<bootp>` to the network config, ex: /etc/libvirt/qemu/networks/default.xml  
```xml
<dhcp>
  ...
  <bootp file='pxelinux.0' server='x.x.x.x'/>
</dhcp>
```
### Run
```commandline
docker build -t pxeserver .
docker run -dt --network=host -v $(pwd)/pxelinux.cfg:/srv/tftp/pxelinux.cfg:ro pxeserver
docker run -dt -p 80:80 -v $(pwd)/httpd:/usr/local/apache2/htdocs httpd:alpine3.17
```
### Tested with:
- [Ubuntu 22.04.2 amd64 ISO](https://releases.ubuntu.com/jammy/ubuntu-22.04.2-live-server-amd64.iso)