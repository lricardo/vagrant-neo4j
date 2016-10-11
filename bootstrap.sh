#DNS fix for this machine
sudo rm /etc/resolv.conf
sudo ln -s ../run/resolvconf/resolv.conf /etc/resolv.conf
sudo resolvconf -u

# Install Oracle Java 6
add-apt-repository ppa:webupd8team/java
apt-get update
# Disable prompting
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
apt-get install oracle-java8-installer -y

#Install neo4j
#Credits:

wget --no-check-certificate -O - https://debian.neo4j.org/neotechnology.gpg.key | apt-key add -

echo 'deb http://debian.neo4j.org/repo stable/' >/etc/apt/sources.list.d/neo4j.list

apt-get -y update
apt-get -y install neo4j

#Enable listening
sed -i s/"# wqdbms.connector.http.address=0.0.0.0:7474"/"dbms.connector.http.address=0.0.0.0:7474"/g /etc/neo4j/neo4j.conf

#Enable at startup
systemctl enable neo4j
