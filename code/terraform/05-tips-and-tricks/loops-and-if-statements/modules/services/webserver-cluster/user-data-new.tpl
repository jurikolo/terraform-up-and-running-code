#!/bin/bash

sudo yum update -y
sudo yum install httpd -y
sudo sed -i 's/Listen 80/Listen ${server_port}/g' /etc/httpd/conf/httpd.conf
export sourceip=`curl -X POST https://source-ip.jurikolo.name`

sudo cat > /var/www/html/index.html <<EOF
<h1>Hello, World v2</h1>
<p>DB address: ${db_address}</p>
<p>DB port: ${db_port}</p>
EOF

sudo echo "Source IP: $sourceip" >> /var/www/html/index.html

sudo systemctl start httpd