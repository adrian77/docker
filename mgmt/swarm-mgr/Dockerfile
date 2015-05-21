FROM swarm:0.2.0
MAINTAINER Adrian Szwej <adrian.szwej@gmail.com>
# The following docker file provides swarm mamanger that read /etc/nodes.conf 
#
CMD    ["manage","--strategy=random","file:///etc/swarm/nodes.conf"]
