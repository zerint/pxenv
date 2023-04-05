FROM ubuntu:jammy
RUN apt update
RUN apt install tftpd-hpa -y
RUN apt install syslinux pxelinux -y
COPY tftp/* /srv/tftp/
RUN cp /usr/lib/PXELINUX/pxelinux.0 /srv/tftp/
RUN cp /usr/lib/syslinux/modules/bios/ldlinux.c32 /srv/tftp/
RUN cp /usr/lib/syslinux/modules/bios/libcom32.c32 /srv/tftp/
RUN cp /usr/lib/syslinux/modules/bios/libutil.c32 /srv/tftp/
RUN cp /usr/lib/syslinux/modules/bios/vesamenu.c32 /srv/tftp/
CMD ["/usr/sbin/in.tftpd", "-L", "--listen", "--address", ":69", "--secure", "/srv/tftp"]
