FROM binhex/arch-base
MAINTAINER binhex

# install application
#####################

# update package databases for arch
RUN pacman -Sy --noconfirm

# run packer to install application
RUN packer -S nzbget-svn --noconfirm

# copy pre check bash shell script (checks for existence of nzbget config)
RUN cp nzbget-precheck.sh /tmp/

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

# set permissions
#################

# change owner
RUN chown -R nobody:users /usr/bin/nzbget

# set permissions
RUN chmod -R 775 /usr/bin/nzbget

# add conf file
###############

ADD nzbget.conf /etc/supervisor/conf.d/nzbget.conf

# cleanup
#########

# completely empty pacman cache folder
RUN pacman -Scc --noconfirm

# remove temporary files
RUN rm -rf /tmp/*

# run supervisor
################

# run supervisor
CMD ["supervisord", "-c", "/etc/supervisor.conf", "-n"]
