#!/bin/bash

# Redirect all output to a log file for debugging
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "Starting User Data Script..."

# Set non-interactive mode
export DEBIAN_FRONTEND=noninteractive

# Terraform will replace these placeholders with real values
RDS_ENDPOINT="${RDS_Endpoint}"
DB_USER="${db_username}"
DB_PASS="${db_password}"
MEMCACHE_ENDPOINT="${ElastiCache_Endpoint}"
MQ_ENDPOINT="${RabbitMQ_broker_endpoint}"
MQ_USER="${Amazon-MQ-username}"
MQ_PASS="${Amazon-MQ-password}"
TOMURL="https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.75/bin/apache-tomcat-9.0.75.tar.gz"
REPO="https://github.com/Omarh4700/Workshop.git"
WEBAPPS="/usr/local/tomcat/webapps"
APP_PROPERTIES="src/main/resources/application.properties" 

# Updating system
echo " |Updating system and installing dependencies...| "
sudo apt update -y && sudo apt install -y openjdk-11-jdk git maven wget


cd /tmp/

# Downloading Tomcat
echo " |Downloading and installing Tomcat...| "
wget $TOMURL -O apache-tomcat-9.0.75.tar.gz
tar xzvf apache-tomcat-9.0.75.tar.gz

# Setting up Tomcat user
echo " |Setting up Tomcat user and permissions...| "
sudo useradd --home-dir /usr/local/tomcat --shell /usr/sbin/nologin tomcat
sudo mkdir -p /usr/local/tomcat
sudo cp -r /tmp/apache-tomcat-9.0.75/* /usr/local/tomcat/
sudo chown -R tomcat:tomcat /usr/local/tomcat

# Creating systemd service
echo " |Creating systemd service file for Tomcat...| "
sudo bash -c 'cat <<EOT > /etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat
Environment="JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64"
Environment="CATALINA_PID=/usr/local/tomcat/temp/tomcat.pid"
Environment="CATALINA_HOME=/usr/local/tomcat"
Environment="CATALINA_BASE=/usr/local/tomcat"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
Environment="JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"

ExecStart=/usr/local/tomcat/bin/startup.sh
ExecStop=/usr/local/tomcat/bin/shutdown.sh

Restart=on-failure

[Install]
WantedBy=multi-user.target
EOT'

sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat

cd /tmp/

# Deploying application
echo " |Deploying application...| "
git clone -b Vagrant $REPO
cd Workshop/Vagrant-Manual-Automation/sourcecodeseniorwr

# --- DYNAMIC CONFIGURATION INJECTION ---
echo " |Updating database credentials in application.properties...| "

# RDS
# We use double quotes (") so bash can expand $RDS_ENDPOINT
# We use pipe (|) delimiter to avoid clashes with slashes in URLs
sed -i "s|jdbc.url=.*|jdbc.url=jdbc:mysql://$RDS_ENDPOINT:3306/accounts?useUnicode=true\&characterEncoding=UTF-8\&zeroDateTimeBehavior=convertToNull|" $APP_PROPERTIES
sed -i "s/^jdbc.username=.*/jdbc.username=$DB_USER/" $APP_PROPERTIES
sed -i "s/^jdbc.password=.*/jdbc.password=$DB_PASS/" $APP_PROPERTIES

# ElastiCache
sed -i "s/^memcached.active.host=.*/memcached.active.host=$MEMCACHE_ENDPOINT/" $APP_PROPERTIES
sed -i "s/^memcached.standBy.host=.*/memcached.standBy.host=$MEMCACHE_ENDPOINT/" $APP_PROPERTIES

# AmazonMQ
sed -i "s|^rabbitmq.address=.*|rabbitmq.address=$MQ_ENDPOINT|" $APP_PROPERTIES
sed -i "s/^rabbitmq.port=.*/rabbitmq.port=5671/" $APP_PROPERTIES
sed -i "s/^rabbitmq.username=.*/rabbitmq.username=$MQ_USER/" $APP_PROPERTIES
sed -i "s/^rabbitmq.password=.*/rabbitmq.password=$MQ_PASS/" $APP_PROPERTIES

# Building
echo " |Building the application...| "
mvn clean install

sudo systemctl stop tomcat
sleep 20 

# Deploying WAR
echo " |Deploying the WAR file...| "
sudo rm -rf $WEBAPPS/ROOT*
sudo cp target/vprofile-v2.war $WEBAPPS/ROOT.war
sudo chown -R tomcat:tomcat $WEBAPPS

sudo systemctl start tomcat
sleep 20

echo " |Deployment complete!| "