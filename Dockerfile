FROM binhex/arch-base:2015010500
MAINTAINER binhex

# additional files
##################

# copy prerun bash shell script (checks for existence of nzbget config)
ADD start.sh /home/nobody/start.sh

# add supervisor conf file for app
ADD nzbget.conf /etc/supervisor/conf.d/nzbget.conf

# install app
#############

# install install app using pacman, set perms, cleanup
RUN pacman -Sy --noconfirm && \
	pacman -S nzbget --noconfirm && \
	pacman -Scc --noconfirm && \
	chown -R nobody:users /usr/bin/nzbget /usr/share/nzbget/nzbget.conf /home/nobody/start.sh && \
	chmod -R 775 /usr/bin/nzbget /usr/share/nzbget/nzbget.conf /home/nobody/start.sh && \
	rm -rf /usr/share/locale/* && \
	rm -rf /usr/share/man/* && \
	rm -rf /root/* && \
	rm -rf /tmp/*
	
# docker settings
#################

# map /config to host defined config path (used to store configuration from app)
VOLUME /config

# map /data to host defined data path (used to store downloads or use blackhole)
VOLUME /data

# map /media to host defined media path (used to read/write to media library)
VOLUME /media

# expose port for http
EXPOSE 6789

# run supervisor
################

# run supervisor
CMD ["supervisord", "-c", "/etc/supervisor.conf", "-n"]