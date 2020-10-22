setenforce 0
echo "setenforce" 

yum install httpd -y &> /dev/null 
echo "httpd installed"

systemctl start httpd 
echo "httpd start" 

firewall-cmd --add-service=http &> /dev/null 
echo "firewall open" 

yum install wget -y &> /dev/null
echo "wget installed" 

wget https://www.free-css.com/assets/files/free-css-templates/download/page258/sentra.zip &> /dev/null
echo "website templete download" 

unzip sentra.zip &> /dev/null 

mv templatemo_518_sentra /var/www/html/ocean
echo "you can start website"
