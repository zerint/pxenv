FROM ubuntu:jammy
RUN apt update
RUN apt install tftpd-hpa -y
RUN apt install syslinux -y
COPY tftp/* /srv/tftp/
RUN ln -s /usr/lib/PXELINUX/pxelinux.0 /var/tftp/
RUN ln -s /usr/lib/syslinux/modules/bios/ldlinux.c32 /var/tftp/
RUN ln -s /usr/lib/syslinux/modules/bios/libcom32.c32 /var/tftp/
RUN ln -s /usr/lib/syslinux/modules/bios/libutil.c32 /var/tftp/
RUN ln -s /usr/lib/syslinux/modules/bios/vesamenu.c32 /var/tftp/
CMD ["/usr/sbin/in.tftpd", "-L", "--listen", "--address", ":69", "--secure", "/srv/tftp"]
