rm -rf /var/www/html/ocean && echo "remove ocean" && rm sentra.zip && echo "remove sentra.zip" && echo "remove httpd" && yum remove httpd -y &> /dev/null && echo "remove httpd success" && echo "remove wget" && yum remove wget -y &> /dev/null && echo "remove wget success" && firewall-cmd --remove-service=http &> /dev/null && echo "firewall close"
