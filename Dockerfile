FROM ubuntu:jammy
RUN apt update
RUN apt install tftpd-hpa -y
COPY tftp/* /srv/tftp/
CMD ["/usr/sbin/in.tftpd", "-L", "--listen", "--address", ":69", "--secure", "/srv/tftp"]
