FROM ubuntu:trusty
MAINTAINER Chris Hardekopf <chrish@basis.com>

# Install subversion and supporting packages (for hooks)
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y subversion \
    svnmailer && \
    rm -rf /var/lib/apt/lists/*

# Put sasl configuration in place
ADD svn.conf /usr/lib/sasl2/

# Archives and configuration are stored in /svn
VOLUME [ "/svn" ]

# Expose public port for svnserve
EXPOSE 3690

# Run the svnserve server
CMD [ "/usr/bin/svnserve", "--daemon", "--foreground", "--root", "/svn" ]

