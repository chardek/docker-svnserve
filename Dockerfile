FROM ubuntu:trusty
MAINTAINER Chris Hardekopf <chrish@basis.com>

# Install subversion and supporting packages (for hooks)
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y subversion \
    svnmailer msmtp msmtp-mta \
    python perl && \
    rm -rf /var/lib/apt/lists/*

# Put sasl configuration in place, this expects to find the
# sasl password stuff at /svn/svn.sasldb
ADD svn.conf /usr/lib/sasl2/

# Set up msmtp pointing to /svn/msmtprc
RUN rm -f /etc/msmtprc && \
    ln -s /svn/msmtprc /etc/msmtprc

# Archives and configuration are stored in /svn
VOLUME [ "/svn" ]

# Expose public port for svnserve
EXPOSE 3690

# Run the svnserve server
CMD [ "/usr/bin/svnserve", "--daemon", "--foreground", "--root", "/svn" ]

