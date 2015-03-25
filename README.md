docker-svnserve
===============

Run an svnserve to server subversion archives from a /svn volume. This image
expects all archives to be found under /svn and makes sasl available for
authentication/encryption with the sasl password database in /svn/svn.sasldb.
The image also uses msmtp to make sendmail available with the configuration
expected to be mounted at /etc/msmtprc and has svnmailer already installed. In addition, python and perl are both installed for use in subversion archive hooks.

In summary, /svn is the persistent data volume expected with the following
properties:
* /svn/<archive> for as many subversion archives as desired
* /svn/svn.sasldb for the subversion sasl user/password database
It also expects a volume mounted for msmtp configuration:
* /etc/msmtprc

You might also want to control what uid and gid that svnserver uses. The default created user name is "svnserve", but can be changed. You can do so by setting environment variables:
* SVN_UID
* SVN_GID
* SVN_USER

Connections are not normally logged, but you can change that by setting the environment variable CONNECTION_LOG. You can get svnserve to log inside the container by setting the environment variable SVN_LOG to the log file location. Remember that the SVN_UID must be able to write the svnserve log file.


 

