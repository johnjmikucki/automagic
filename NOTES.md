

# Installing Docker

sudo yum install 'docker' # or 'docker-io' depending on your host OS/version

* Note: If you need to run a private repo, you'll probably want one of these images to prettify the UI:

> NAME                                    DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
> atcol/docker-registry-ui                A web UI for easy private/local Docker Reg...   21                   [OK]
> konradkleine/docker-registry-frontend   a pure web-based solution for browsing and...   4                    [OK]
> tomaskral/docker-registry-web                                                           0                    [OK]
> cloudaku/docker-registry-web                                                            0                    [OK]
> geodan/registry-ui                      Docker Registry Web Interface                   0                    [OK]

Note: Docker deliberately prevents you from changing the 'root'/default hub for things like Centos.  They want it to
point to them ostensibly for consistency (laudable) and probably market share  (quel surprise).
Easiest way to work around this is probably to just spoof the DNS entry for docker.io to your in-house docker hub.


# Jenkins

If you don't already have a Jenkins container, "sudo docker pull jenkins"


