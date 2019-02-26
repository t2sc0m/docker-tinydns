FROM adite/base

ENV DEBIAN_FRONTEND noninteractive

# install packages
RUN apt-get update && apt-get install -y djbdns daemontools-run ucspi-tcp psmisc

# add user
RUN useradd -s /bin/false tinydns && \
    useradd -s /bin/false dnscache && \
    useradd -s /bin/false dnslog

# set tinydns 
RUN tinydns-conf tinydns dnslog /etc/tinydns/ 127.0.0.1

# set dnscache
RUN dnscache-conf dnscache dnslog /etc/dnscache 0.0.0.0
RUN echo "127.0.0.1" > /etc/dnscache/root/servers/dev
#RUN touch /etc/dnscache/root/ip/192
#RUN touch /etc/dnscache/root/ip/172
#RUN touch /etc/dnscache/root/ip/10
RUN ln -s /etc/tinydns /etc/service/tinydns
RUN ln -s /etc/dnscache /etc/service/dnscache

# add scripts
ADD init.sh /init.sh
ADD data /etc/tinydns/root/data

# expose port
EXPOSE 53/tcp 53/udp

# set volume 
VOLUME /etc/tinydns
VOLUME /etc/dnscache

CMD ["/init.sh"]
